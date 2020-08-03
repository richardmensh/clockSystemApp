//
//  CompaniesPresenter.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 29/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//
import UIKit

protocol CompaniesPresenterProtocol: NSObjectProtocol {
	func obtainCompanies()
	func eventsDeleted()
}

class CompaniesPresenter {
	
	// MARK: - Public variables
	weak var viewCompanies:CompaniesPresenterProtocol?
	private let clockSystemManager = ClockSystemManager.shared
	var companies: [Company] = []
	var events: [Event] = []
	var companyId = ""
	var eventsDeleted = true
	
	func attachView(view: CompaniesPresenterProtocol) {
		self.viewCompanies = view
	}
	
	func detachView() {
		self.viewCompanies = nil
	}
	
	func getCompanies() {
		clockSystemManager.getCompanies(target: ClockSystemApi.companies) {
			[weak self] results, error in
			print("in get companies")
			if let unwappred = results {
				self?.companies = unwappred
				self?.viewCompanies?.obtainCompanies()
			} else {
				print("error in getCompanies \(error?.localizedDescription ?? "")")
			}
		}
	}
	
	func getEvents() {
		clockSystemManager.getEvents(target: ClockSystemApi.events) {
			[weak self] results, error in
			if let unwappred = results {
				self?.events = unwappred
				self?.viewCompanies?.obtainCompanies()
			} else {
				print("error in events \(error?.localizedDescription ?? "")")
			}
		}
	}
	
	func deleteEvent(id: String) {
		clockSystemManager.deleteObject(target: ClockSystemApi.deleteEvent(id: id)) {
			result, error in
			if let _ = result {
				self.companyId = ""
			} else {
				print("error in delete company \(error?.localizedDescription ?? "" )")
			}
		}
	}
	
	func deleteCompany(id: String) {
		eventsDeleted = false
		clockSystemManager.deleteCompany(target: ClockSystemApi.deleteCompany(id: id)) {
			[weak self] results, error in
			if let unwappred = results {
				var index = 0
				self?.companies.forEach { company in
					if company.id == unwappred.id {
						self?.companies.remove(at: index)
					} else {
						index += 1
					}
				}
				self?.companyId = unwappred.id
				self?.getEvents()
			} else {
				print("error in getCompanies \(error?.localizedDescription ?? "")")
			}
		}
	}
}
