//
//  MapPresenter.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 18/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//
import UIKit

protocol MapPresenterProtocol: NSObjectProtocol {
	func navigateBack()
}

class MapPresenter {
	
	// MARK: - Public variables
	weak var viewMap:MapPresenterProtocol?
	
	func attachView(view: MapPresenterProtocol) {
		self.viewMap = view
	}
	
	func detachView() {
		self.viewMap = nil
	}
	
	func backButtonPressed() {
		viewMap?.navigateBack()
	}
}
