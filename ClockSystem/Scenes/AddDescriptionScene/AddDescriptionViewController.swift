//
//  AddDescriptionViewController.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 15/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//

import UIKit

class AddDescriptionViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var navigationBar: UIView!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var containerView: UIView!
	
	@IBOutlet var descLabels: [UILabel]!
	@IBOutlet var descTextFields: [UITextField]!
	
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var locationTextField: UITextField!
	@IBOutlet weak var clockInLabel: UILabel!
	@IBOutlet weak var clockInTextField: UITextField!
	@IBOutlet weak var rateDayLabel: UILabel!
	@IBOutlet weak var rateDayView: UIView!
	@IBOutlet weak var eventDescriptionLabel: UILabel!
	@IBOutlet weak var eventDescriptionTextView: UITextView!
	@IBOutlet weak var addButton: UIButton!
	
	@IBOutlet weak var clockOutLabel: UILabel!
	@IBOutlet weak var clockOutTextField: UITextField!
	
	let presenter: AddDescriptionPresenter = AddDescriptionPresenter()
	
	var clockInTime: String?
	var clockOutTime: String?
	
	var activeTextField: UITextField!
	var activeTextView: UITextView!
	
	var company: Company?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter.attachView(view: self)
		setupLabels()
		setupViews()
		setupButtons()
		setupTextFields()
		
		NotificationCenter.default.addObserver(self, selector: #selector(_KeyboardHeightChanged(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(_KeyboardHeightChanged(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(_KeyboardHeightChanged(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
		
	}
	deinit {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
	}
	
}

private extension AddDescriptionViewController {
	func setupLabels() {
		titleLabel.text = "Add description"
		titleLabel.font = .camptonBold(ofSize: 20)
		titleLabel.textColor = .white
		
		descLabels.forEach { label in
			label.font = .camptonBook(ofSize: 15)
			label.textColor = .descLabelColor
		}
		locationLabel.text = "Location"
		clockInLabel.text = "Clock In"
		clockOutLabel.text = "Clock Out"
		rateDayLabel.text = "Rate your event"
		eventDescriptionLabel.text = "Event description"
		
	}
	
	func setupViews() {
		view.backgroundColor = .mainBackground
		navigationBar.backgroundColor = .clear
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
		containerView.layer.cornerRadius = 25
		containerView.backgroundColor = .white
		containerView.layer.masksToBounds = true
	}
	
	func setupButtons() {
		backButton.setImage(#imageLiteral(resourceName: "icons8-back").withRenderingMode(.alwaysTemplate), for: .normal)
		backButton.tintColor = .white
		backButton.setTitle("", for: .normal)
		backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
		
		addButton.setTitle("Clock out", for: .normal)
		addButton.setTitleColor(.white, for: .normal)
		addButton.backgroundColor = .mainBackground
		addButton.layer.cornerRadius = 20
		addButton.layer.masksToBounds = true
		addButton.addTarget(self, action: #selector(clockOutButtonPressed), for: .touchUpInside)
		
	}
	
	func setupTextFields() {
		eventDescriptionTextView.text = ""
		eventDescriptionTextView.textColor = .black
		eventDescriptionTextView.delegate = self
		eventDescriptionTextView.font = .camptonBold(ofSize: 15)
		eventDescriptionTextView.layer.borderWidth = 1
		eventDescriptionTextView.layer.borderColor = UIColor.descLabelColor.cgColor
		eventDescriptionTextView.backgroundColor = .white
		eventDescriptionTextView.layer.cornerRadius = 20
		eventDescriptionTextView.layer.masksToBounds = true
		descTextFields.forEach { textField in
			textField.font = .camptonBold(ofSize: 20)
			textField.layer.borderWidth = 1
			textField.layer.borderColor = UIColor.descLabelColor.cgColor
			textField.setLeftPaddingPoints(10)
			textField.setRightPaddingPoints(10)
			textField.textColor = .black
			textField.layer.cornerRadius = 20
			textField.layer.masksToBounds = true
			textField.delegate = self
		}
		if let clockIn = clockInTime,
		let clockOut = clockOutTime, let company = company  {
			clockInTextField.text = clockIn
			clockOutTextField.text = clockOut
			locationTextField.text = company.address
		}
	}
	
	@objc func backButtonPressed() {
		presenter.backButtonPressed()
	}
	
	
	@objc  func _KeyboardHeightChanged(_ notification: Notification) {
		UIView.animate(withDuration: 0.5, animations: {
			guard let keyboardRect =
				(notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
				else { return }
			
			if notification.name == UIResponder.keyboardWillChangeFrameNotification ||
				notification.name == UIResponder.keyboardWillShowNotification {
				#warning("Check wheather view is textfield or textview")
				let keyboardY = self.view.frame.size.height  - keyboardRect.height
//				let activeTextFieldY = self.activeTextField.frame.origin.y
				let activeTextViewY: CGFloat! = self.activeTextView?.frame.origin.y
//				if (activeTextFieldY) > keyboardY - 60 {
//					self.view.frame.origin.y = self.view.frame.origin.y - (activeTextFieldY - (keyboardY - 60))
//				} else
				print(activeTextViewY, keyboardY)
					if activeTextViewY > keyboardY - 60 {
						self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (activeTextViewY - (keyboardY - 20)), width: self.view.bounds.width, height: self.view.bounds.height)
				}
				
			} else {
				self.view.frame.origin.y = 0
			}
		})
	}
}

extension AddDescriptionViewController: UITextFieldDelegate, UITextViewDelegate {
	
	func textFieldDidBeginEditing(_ textField: UITextField) {
		activeTextField = textField
	}
	func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
		activeTextView = textView
		return true
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
	
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
	
}
