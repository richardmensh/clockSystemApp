//
//  CompanyCollectionViewCell.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 29/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

class CompanyCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var roundedView: UIView!
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var removeButton: UIButton!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.backgroundColor = .clear
		setupViews()
		setupLabels()
		setupImageView()
    }
	
	func config(company: Company, remove: Bool) {
		nameLabel.text = company.name
		removeButton.isHidden = !remove
	}
}

private extension CompanyCollectionViewCell {
	
	func setupLabels() {
		nameLabel.font = .camptonBold(ofSize: 20)
		nameLabel.textColor = .white
	}
	
	func setupImageView () {
		
	}
	
	func setupViews() {
		roundedView.layer.cornerRadius = 20
		roundedView.backgroundColor = .darkBlue
	}
	
}

extension CompanyCollectionViewCell: ReusableView, NibLoadableView {}

