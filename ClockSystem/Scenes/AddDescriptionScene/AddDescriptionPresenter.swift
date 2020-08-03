//
//  AddDescriptionPresenter.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 15/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//
import UIKit

protocol AddDescriptionPresenterProtocol: NSObjectProtocol {
	func navigateBack()
	func clockOut()
}

class AddDescriptionPresenter {
	
	// MARK: - Public variables
	weak var viewAddDescription:AddDescriptionPresenterProtocol?
	private let clockSystemManager = ClockSystemManager.shared
	
	func attachView(view: AddDescriptionPresenterProtocol) {
		self.viewAddDescription = view
	}
	
	func detachView() {
		self.viewAddDescription = nil
	}
	
	func addEvent(data: [String: Any]) {
		clockSystemManager.addEvent(target: ClockSystemApi.addEvent(data: data)) {
			[weak self] results, error in
			if let _ = results {
				self?.viewAddDescription?.clockOut()
			} else {
				print("error in getCompanies \(error?.localizedDescription ?? "")")
			}
		}
	}
	
	func backButtonPressed() {
		viewAddDescription?.navigateBack()
	}
	
	func clockOutButtonPressed() {
		viewAddDescription?.clockOut()
	}
}
