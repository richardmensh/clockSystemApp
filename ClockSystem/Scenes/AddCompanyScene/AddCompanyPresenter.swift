//
//  AddCompanyPresenter.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 29/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//
import UIKit

protocol AddCompanyPresenterProtocol: NSObjectProtocol {
	func companyAdded()
}

class AddCompanyPresenter {
	
	// MARK: - Public variables
	weak var viewAddCompany:AddCompanyPresenterProtocol?
	private let clockSystemManager = ClockSystemManager.shared
	
	func attachView(view: AddCompanyPresenterProtocol) {
		self.viewAddCompany = view
	}
	
	func detachView() {
		self.viewAddCompany = nil
	}
	
	func addCompany(data: [String: Any]) {
		clockSystemManager.addCompany(target: ClockSystemApi.addCompany(data: data)) {
			[weak self] results, error in
			if let _ = results {
				self?.viewAddCompany?.companyAdded()
			} else {
				print("error in getCompanies \(error?.localizedDescription ?? "")")
			}
		}
	}
	
}
