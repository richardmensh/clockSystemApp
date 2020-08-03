//
//  ClockPresenter.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 13/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//
import UIKit

protocol ClockPresenterProtocol: NSObjectProtocol {
	func clcokIn()
	func clockOut()
}

class ClockPresenter {
	
	// MARK: - Public variables
	weak var viewClock:ClockPresenterProtocol?
	private let clockSystemManager = ClockSystemManager.shared
	var companies: [Company] = []
	
	func attachView(view: ClockPresenterProtocol) {
		self.viewClock = view
	}
	
	func detachView() {
		self.viewClock = nil
	}
	
	func clockInPressed() {
		viewClock?.clcokIn()
	}
	
	func clockOutPressed() {
		viewClock?.clockOut()
	}
	
}
