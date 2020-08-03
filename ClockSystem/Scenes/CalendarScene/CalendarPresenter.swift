//
//  CalendarPresenter.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 19/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//
import UIKit

protocol CalendarPresenterProtocol: NSObjectProtocol {
	func navigateBack()
	func obtainEvents()
	func obtainCompany()
}

class CalendarPresenter {
	
	// MARK: - Public variables
	weak var viewCalendar:CalendarPresenterProtocol?
	var events: [Event] = []
	var eventsOnADay: [Event] = []
	var companies: [Company] = []
	
	private let clockSystemManager = ClockSystemManager.shared
	
	func attachView(view: CalendarPresenterProtocol) {
		self.viewCalendar = view
	}
	
	func detachView() {
		self.viewCalendar = nil
	}
	
	func getEvents() {
		clockSystemManager.getEvents(target: ClockSystemApi.events) {
			[weak self] results, error in
			if let unwappred = results{
				self?.events = unwappred
				self?.getCompanies()
			} else {
				print("error in getCompanies \(error?.localizedDescription ?? "")")
			}
		}
	}
	
	func getCompanies() {
		clockSystemManager.getCompanies(target: ClockSystemApi.companies) {
			[weak self] results, error in
			print("in get companies")
			if let unwappred = results {
				self?.companies = unwappred
				self?.viewCalendar?.obtainEvents()
			} else {
				print("error in getCompanies \(error?.localizedDescription ?? "")")
			}
		}
	}
	
	func backButtonPressed() {
		viewCalendar?.navigateBack()
	}
}
