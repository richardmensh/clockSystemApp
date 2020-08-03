//
//  AddDescriptionActions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 15/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit


extension AddDescriptionViewController {
	 @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
		 view.resignFirstResponder()
	 }
	
	@objc func clockOutButtonPressed() {
		var data: [String: Any] = [:]
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
		dateFormatter.locale = Locale(identifier: "nl-NL")
		let dateInFormat = dateFormatter.string(from: Date())
		guard let dateIn = dateFormatter.date(from: dateInFormat) else { return }
		let timeStamp = dateIn.timeIntervalSince1970
//		let dateTimeStamp = dateNow.timeIntervalSince1970
		print(timeStamp)
		if  let company = company,
			let clockIn = clockInTextField.text,
			let clockOut = clockOutTextField.text  {
			data["companyId"] = company.id
			data["clockIn"] = clockIn
			data["clockOut"] = clockOut
			data["scale"] = 0
			data["description"] = eventDescriptionTextView.text
			data["eventDate"] = String(timeStamp)
			data["role"] = company.functions.first!
			presenter.addEvent(data: data)
		}
		
	}
}
extension AddDescriptionViewController: AddDescriptionPresenterProtocol {
	func navigateBack() {
		self.dismiss(animated: true, completion: nil)
	}
	
	func clockOut() {
		let defaults = UserDefaults.standard
		
		defaults.set(false, forKey: "isUserClockedIn")
		NotificationCenter.default.post(name: .didClockedOut, object: nil, userInfo: ["boolean": false])
		self.dismiss(animated: true, completion: nil)
	}
}


