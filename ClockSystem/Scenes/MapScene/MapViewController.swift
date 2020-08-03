//
//  MapViewController.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 18/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var mapView: MGLMapView!
	@IBOutlet weak var remindMeLabel: UILabel!
	@IBOutlet weak var remindMeSwitch: UISwitch!
	
	let presenter: MapPresenter = MapPresenter()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter.attachView(view: self)
		view.backgroundColor = .mainBackground
		
		setupLabels()
		setupButtons()
		setupMapBox()
	}
}

private extension MapViewController {
	func setupLabels() {
		remindMeLabel.text = "Remind me to clock in"
		remindMeLabel.font = .camptonBold(ofSize: 20)
		remindMeLabel.textColor = .white
	}
	
	func setupButtons() {
		backButton.setImage(#imageLiteral(resourceName: "icons8-back").withRenderingMode(.alwaysTemplate), for: .normal)
		backButton.tintColor = .white
		backButton.setTitle("", for: .normal)
		backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
	}
	
	func setupMapBox() {
		mapView.delegate = self
//		locationMapView.showsUserLocation = true
		let locValue: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 52.332391, longitude: 4.921986)
		mapView.longitude = locValue.longitude
		mapView.latitude = locValue.latitude
		mapView.setCenter(locValue, zoomLevel: 9, direction: 0, animated: false)
		let point = MGLPointAnnotation()
		point.coordinate = locValue
		point.title = "Picnic DVT"
		mapView.addAnnotation(point)
	}
	
	@objc func backButtonPressed() {
		presenter.backButtonPressed()
	}
}
