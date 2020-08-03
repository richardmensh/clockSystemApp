//
//  ClockViewController.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 13/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//

import UIKit
import Mapbox
import EzPopup

class ClockViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var navigationBar: UIView!
	@IBOutlet weak var companyNameLabel: UILabel!
	@IBOutlet weak var dashboardButton: UIButton!
	@IBOutlet weak var calendarButton: UIButton!
	
	@IBOutlet var navigationButtons: [UIButton]!
	@IBOutlet weak var functionLabel: UILabel!
	@IBOutlet var clockImageViews: [UIImageView]!
	@IBOutlet var clockLabels: [UILabel]!
	@IBOutlet weak var mapImageView: UIImageView!
	@IBOutlet weak var clockInView: UIView!
	@IBOutlet weak var clockOutView: UIView!
	@IBOutlet var clockViews: [UIView]!
	@IBOutlet weak var clockInLabel: UILabel!
	@IBOutlet weak var clockOutLabel: UILabel!
	@IBOutlet weak var clockDescLabel: UILabel!
	@IBOutlet weak var clockedInTimeLabel: UILabel!
	
	let presenter: ClockPresenter = ClockPresenter()
	let popupManager = PopupManager()
	var isClockIn = false
	var clockInTime: String?
	var company: Company?
	let isUserClockedIn = "isUserClockedIn"
	let clockInTimeVar = "clockInTime"
	let COMPANYID = "companyID"
	let functionPicker: UIPickerView = UIPickerView()
	var functions: [String] = []
	var function = "Select your function"
	var compareCompayID = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter.attachView(view: self)
		view.backgroundColor = .mainBackground
		navigationBar.backgroundColor = .clear
		let defaults = UserDefaults.standard
		let storedClockedInBool = defaults.bool(forKey: isUserClockedIn)
		let storedClockedInTime = defaults.string(forKey: clockInTimeVar)
		let storeCompanyID = defaults.string(forKey: COMPANYID)
		compareCompayID = storeCompanyID ?? ""
		isClockIn = storedClockedInBool
		clockInTime = storedClockedInTime
		
		
		NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: .didClockedOut, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectFunctionData(_:)), name: .didSelectFuntion, object: nil)
		
		toggleClockView()
		
		setupLabels()
		setupButtons()
		setupViews()
		setupImageViews()
		configCompany()
	}

}

private extension ClockViewController {
	func configCompany() {
		guard let company = company else { return }
		companyNameLabel.text = company.name
		if company.id != compareCompayID {
			isClockIn = false
			toggleClockView()
		}
		
		if company.functions.count > 1 {
			// let user select
			functions = company.functions
			functionLabel.addGestureRecognizer(
				UITapGestureRecognizer(target: self, action: #selector(functionLabelPressed))
			)
		} else {
			function = company.functions.first ?? ""
		}
		functionLabel.text = function
		
		
	}
	
	@objc func onDidReceiveData(_ notification: Notification) {
		if let data = notification.userInfo as? [String: Any] {
			_ = data.map {
				guard let test = $0.value as? Bool else { return }
				
				isClockIn = test
				toggleClockView()
			}
		}
	}
	
	@objc func onDidSelectFunctionData(_ notification: Notification) {
		if let data = notification.userInfo as? [String: Any] {
			_ = data.map {
				guard let function = $0.value as? String else { return }
				functionLabel.text = "Role: \(function)"
			}
		}
	}
	
	func setupLabels() {
		companyNameLabel.font = .camptonBold(ofSize: 20)
		companyNameLabel.textColor = .white
		
		functionLabel.font = .camptonBold(ofSize: 40)
		functionLabel.textColor = .white
		functionLabel.isUserInteractionEnabled = true
		
		clockLabels.forEach { label in
			label.textColor = .white
			label.font = .camptonBold(ofSize: 20)
		}
		
		clockInLabel.text = "Clock in"
		clockOutLabel.text = "Clock out"
		
		clockDescLabel.text = "Clocked in at"
		clockDescLabel.font = .camptonBold(ofSize: 20)
		clockDescLabel.textColor = .clockLightGray
		
		
		clockedInTimeLabel.font = .camptonBold(ofSize: 30)
		clockedInTimeLabel.textColor = .white
	}
	
	func setupButtons() {
		dashboardButton.setImage(#imageLiteral(resourceName: "ic_squared_menu").withRenderingMode(.alwaysTemplate), for: .normal)
		calendarButton.setImage(#imageLiteral(resourceName: "ic_calendar").withRenderingMode(.alwaysTemplate), for: .normal)
		calendarButton.addTarget(self, action: #selector(navigateToCalendar), for: .touchUpInside)
		
		dashboardButton.addTarget(self, action: #selector(navigateToCompanies), for: .touchUpInside)
		
		navigationButtons.forEach { button in
			button.tintColor = .white
		}
	}
	
	func setupViews() {
		clockViews.forEach { view in
			view.layer.cornerRadius = 25
			view.backgroundColor = .darkBlue
			view.isUserInteractionEnabled = true
			
		}
		clockInView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clockInPressed)))
		clockInView.isUserInteractionEnabled = !isClockIn
		
		clockOutView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clockOutPressed)))
		clockOutView.isUserInteractionEnabled = isClockIn
		
	}
	
	func setupImageViews() {
		clockImageViews.forEach { imageView in
			imageView.image = #imageLiteral(resourceName: "ic_clock").withRenderingMode(.alwaysTemplate)
			imageView.tintColor = .white
		}
		
		mapImageView.image = #imageLiteral(resourceName: "ic_map").withRenderingMode(.alwaysTemplate)
		mapImageView.tintColor = .white
		mapImageView.isUserInteractionEnabled = true
		mapImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(navigateToMap)))
		
	}
	
	@objc func clockInPressed() {
		toggleClockView()
		presenter.clockInPressed()
	}
	
	@objc func clockOutPressed() {
		toggleClockView()
		presenter.clockOutPressed()
	}
	
	@objc func functionLabelPressed() {
		functionPicker.dataSource = self
		functionPicker.delegate = self
		
		let height = view.frame.height * 0.3
		let width = view.frame.width
		let popup = PickerViewController()
		popup.data = functions
		let popupVC = PopupViewController(contentController: popup, position: .bottom(0),
										  popupWidth: width,
										  popupHeight: height)
		
        popupVC.backgroundAlpha = 0.3
        popupVC.backgroundColor = .black
        popupVC.canTapOutsideToDismiss = true
        popupVC.cornerRadius = 10
        popupVC.shadowEnabled = true
        present(popupVC, animated: true, completion: nil)
		
	}
}
