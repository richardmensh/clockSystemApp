//
//  ClockActions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 14/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit
import EzPopup

extension ClockViewController {
	@objc func toggleClockView() {
		if !isClockIn {
			clockOutView.layer.opacity = 0.6
			clockInView.layer.opacity = 1
			clockDescLabel.isHidden = true
			clockedInTimeLabel.isHidden = true
		} else {
			clockInView.layer.opacity = 0.6
			clockOutView.layer.opacity = 1
			clockDescLabel.isHidden = false
			clockedInTimeLabel.isHidden = false
			clockedInTimeLabel.text = clockInTime ?? ""
		}
		clockInView.isUserInteractionEnabled = !isClockIn
		clockOutView.isUserInteractionEnabled = isClockIn
	}
	
	@objc func navigateToMap() {
			let vc = MapViewController()
			vc.modalPresentationStyle = .currentContext
			self.present(vc, animated: true, completion: nil)
	}
	
	@objc func navigateToCalendar() {
		let vc = CalendarViewController()
		vc.modalPresentationStyle = .currentContext
		self.present(vc, animated: true, completion: nil)
	}
	
	@objc func navigateToCompanies() {
		dismiss(animated: true, completion: nil)
	}
}

extension ClockViewController: ClockPresenterProtocol {
	func getCurrentTime() -> String {
		let now = Date()
		
		let formatter = DateFormatter()
		formatter.dateStyle = .none
		formatter.timeStyle = .short
		formatter.dateFormat = "HH:mm"

		let datetime = formatter.string(from: now)
		return datetime
	}
	
	func clockOut() {		
		let clockOutTime = self.getCurrentTime()
		guard let company = self.company else { return }
		guard let clockInTime = self.clockInTime else { return }
		
//
		let popup = ClockOutPopupViewController()
		popup.clockInTime = clockInTime
		popup.clockOutTime = clockOutTime
		popup.company = company
		let height = view.frame.height * 0.3
		let width = view.frame.width
		
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
	
	func clcokIn() {
		let currentTime = getCurrentTime()
		isClockIn = !isClockIn
		toggleClockView()
		clockedInTimeLabel.text = currentTime
		clockInTime = currentTime
		let defaults = UserDefaults.standard
		guard let company = company else { return }
		defaults.set(company.id, forKey: COMPANYID)
		defaults.set(isClockIn, forKey: isUserClockedIn)
		defaults.set(currentTime, forKey: clockInTimeVar)
	
	}
}

extension ClockViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return functions.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return functions[row]
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		functionLabel.text = functions[row]
	}
}
