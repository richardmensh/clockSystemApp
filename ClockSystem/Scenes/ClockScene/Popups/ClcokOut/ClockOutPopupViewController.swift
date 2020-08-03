//
//  ClockOutPopupViewController.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 14/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

class ClockOutPopupViewController: UIViewController {

	@IBOutlet weak var headerLabel: UILabel!
	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var descLabel: UILabel!
	@IBOutlet weak var clockOutButton: UIButton!
	
	var clockInTime: String?
	var clockOutTime: String?
	var company: Company?
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .white
        // Do any additional setup after loading the view.
		setupLabels()
		setupButtons()
    }

}

private extension ClockOutPopupViewController {
	func setupLabels() {
		headerLabel.text = "Clock out"
		headerLabel.font = .camptonBold(ofSize: 30)
		headerLabel.textColor = .black
		
		descLabel.text = "Add description to your event"
		descLabel.font = .camptonMedium(ofSize: 15)
		descLabel.textColor = .black
	}
	
	func setupButtons() {
		clockOutButton.setTitle("Clock out", for: .normal)
		clockOutButton.setTitleColor(.white, for: .normal)
		clockOutButton.backgroundColor = .mainBackground
		clockOutButton.layer.cornerRadius = 20
		clockOutButton.layer.masksToBounds = true
		clockOutButton.addTarget(self, action: #selector(clockOutButtonPressed), for: .touchUpInside)
	}
	
	@objc func clockOutButtonPressed() {
		let vc = AddDescriptionViewController()
		vc.clockInTime = clockInTime
		vc.clockOutTime = clockOutTime
		vc.company = company
		vc.modalPresentationStyle = .currentContext
		self.present(vc, animated: true, completion: nil)
	}
}


