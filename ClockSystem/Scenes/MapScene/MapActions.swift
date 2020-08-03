//
//  MapActions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 18/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit
import Mapbox

extension MapViewController {
	
}

extension MapViewController: MapPresenterProtocol {
	func navigateBack() {
		dismiss(animated: true, completion: nil)
	}
}


extension MapViewController: MGLMapViewDelegate {
	
	// Use the default marker. See also: our view annotation or custom marker examples.
	func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
		return nil
	}
	
	// Allow callout view to appear when an annotation is tapped.
	func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
		return true
	}
	
	func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
		let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, altitude: 4500, pitch: 15, heading: 180)
		
		// Animate the camera movement over 5 seconds.
		mapView.setCamera(camera, withDuration: 5, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
	}
}
