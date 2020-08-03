//
//  EventTableViewCell.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 20/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

	@IBOutlet weak var descRoundedView: UIView!
	@IBOutlet weak var clockInLabel: UILabel!
	@IBOutlet weak var clockOutLabel: UILabel!
	@IBOutlet var clockLabels: [UILabel]!
	@IBOutlet weak var functionLabel: UILabel!
	@IBOutlet weak var addressLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		setupLabels()
		descRoundedView.layer.cornerRadius = 20
    }
	
	func config(event: Event, company: Company) {
		clockInLabel.text = event.clockIn
		clockOutLabel.text = event.clockOut
		addressLabel.text = company.name
		functionLabel.text = event.role
	}
}

private extension EventTableViewCell {
	func setupLabels() {
		clockInLabel.text = "14:10"
		clockOutLabel.text = "22:20"
		
		clockLabels.forEach { label in
			label.font = .camptonLight(ofSize: 15)
			label.textColor = .black
		}
		
		functionLabel.text = "Runner"
		functionLabel.font = .camptonMedium(ofSize: 20)
		functionLabel.textColor = .black
		
		addressLabel.text = "Van marwijk Kooystraat 4"
		addressLabel.font = .camptonMedium(ofSize: 15)
		addressLabel.textColor = .black
	}
}

extension EventTableViewCell: ReusableView, NibLoadableView {}
