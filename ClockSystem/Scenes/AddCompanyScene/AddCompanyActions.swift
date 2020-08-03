//
//  AddCompanyActions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 30/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit
import CoreLocation

extension AddCompanyViewController {
	func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
		let geocoder = CLGeocoder()
		geocoder.geocodeAddressString(address) { (placemarks, error) in
			guard let placemarks = placemarks,
			let location = placemarks.first?.location?.coordinate else {
				completion(nil)
				return
			}
			self.coords = location
			completion(location)
		}
	}
	
	@objc func addCompany() {
		if nameTextField.text != "", addressTextField.text != "" {
			var functions: [String] = []
			functionsTextFields.forEach { textField in
				if textField.text != "" {
					functions.append(textField.text!)
				}
			}
			if let name = nameTextField.text,
				let address = addressTextField.text {
				
				
				var data: [String: Any] = [:]
				data["name"] = name
				data["address"] = address
				data["functions"] = functions
				
				self.presenter.addCompany(data: data)
			}
		}
		
	}
	
	@objc  func _KeyboardHeightChanged(_ notification: Notification) {
			UIView.animate(withDuration: 0.5, animations: {
				guard let keyboardRect =
					(notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
					else { return }
				
				if notification.name == UIResponder.keyboardWillChangeFrameNotification ||
					notification.name == UIResponder.keyboardWillShowNotification {
					#warning("Check wheather view is textfield or textview")
//					print(self.view.frame.origin.y )
//					print(keyboardRect.height)
//					let keyboardY = self.view.frame.origin.y  - keyboardRect.height
//					let activeTextFieldY: CGFloat! = self.activeTextField?.frame.origin.y
//					let textFieldHeight: CGFloat!  = self.activeTextField?.frame.height
////					let activeTextViewY: CGFloat! = self.activeTextView?.frame.origin.y
//	//				if (activeTextFieldY) > keyboardY - 60 {
//	//					self.view.frame.origin.y = self.view.frame.origin.y - (activeTextFieldY - (keyboardY - 60))
//	//				} else
//					print(activeTextFieldY, keyboardY)
//					if activeTextFieldY > (keyboardY - textFieldHeight) {
//						self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (activeTextFieldY - (keyboardY - 20)), width: self.view.bounds.width, height: self.view.bounds.height)
//					}
					
				} else {
					self.view.frame.origin.y = 0
				}
			})
		}
}

extension AddCompanyViewController: AddCompanyPresenterProtocol {
	func companyAdded() {
		NotificationCenter.default.post(name: .companyAdded, object: nil, userInfo: ["boolean": true])
		self.dismiss(animated: true, completion: nil)
	}
	
}


extension AddCompanyViewController: UITextFieldDelegate {

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		activeTextField = textField
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
