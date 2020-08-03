//
//  ClockSystemTextField.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 01/08/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

@IBDesignable
class ClockSystemTextField: UITextField {
	
	@IBInspectable var textInset: Bool = true {
		didSet {
			if textInset {
				let paddingFrame = CGRect(x: 0, y: 0, width: self.frame.width * 0.05, height: self.frame.height)
				let paddingView = UIView(frame: paddingFrame)
				self.leftView = paddingView
				self.leftViewMode = .always
			}
		}
	}
	
	@IBInspectable var lineColor: UIColor = .lightGray
	
	@IBInspectable var placeholderFont: UIFont = .camptonBook(ofSize: 18)

	@IBInspectable var placeholderColor: UIColor = .white
	
	
	/// Check if the textfield contains text.
	var isEmpty: (empty: Bool, text: String)? {
		return checkEmpty()
	}
	
	@IBOutlet var nextTextField: UITextField?
	
	/// Create the textfield with the required UI.
	func setupTextField() {
		let bottomBorder = CALayer()
		bottomBorder.frame = CGRect(x: self.bounds.minX, y: self.bounds.maxY - 1, width: self.bounds.width, height: 1)
		bottomBorder.backgroundColor = lineColor.cgColor
		self.layer.addSublayer(bottomBorder)
		
		self.borderStyle = .none
		
		
		if textInset {
			let paddingFrame = CGRect(x: 0, y: 0, width: self.frame.width * 0.05, height: self.frame.height)
			let paddingView = UIView(frame: paddingFrame)
			self.leftView = paddingView
			self.leftViewMode = .always
		}
	}
	
	
	override func draw(_ rect: CGRect) {
		super.draw(rect)
		
		setupTextField()
		delegate = self
	}
	
	func isValidEmail(text: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		
		let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		return emailTest.evaluate(with: text)
	}
	
}

// MARK: - UITextField Delegate Methods.
extension ClockSystemTextField: UITextFieldDelegate {

	/// focus on the next textfield of the "nextTextField" attribute has been set.
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if let nextField = self.nextTextField {
			DispatchQueue.main.async {
				nextField.becomeFirstResponder()
			}
		} else {
			self.resignFirstResponder()
		}
		
		return true
	}
	
}

// MARK: - UITextField Animations
extension ClockSystemTextField {
	func shakeTextField() {
		let animation = CABasicAnimation(keyPath: "position")
		animation.duration = 0.07
		animation.repeatCount = 4
		animation.autoreverses = true
		self.lineColor = .red
		animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
		animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
		self.layer.add(animation, forKey: "position")
	}
}


// MARK: - Private Functions
extension ClockSystemTextField {
	
	/// Check wether the textfield contains a text or not. if not shake the textfield.
	fileprivate func checkEmpty() -> (Bool, String) {
		guard let text = self.text else {
			shakeTextField()
			return (true, "")
		}
		if keyboardType == .emailAddress {
			if !isValidEmail(text: text) {
				shakeTextField()
				return (true, text)
			} else {
				return (false, text)
			}
		}
		if text.isEmpty {
			shakeTextField()
			return (true, "")
		} else {
			return (false, text)
		}
	}
	
}
