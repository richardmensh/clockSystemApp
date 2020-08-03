//
//  AddCompanyViewController.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 29/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//

import UIKit
import CoreLocation

class AddCompanyViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var contentView: UIView!
	@IBOutlet var contentLabels: [UILabel]!
	@IBOutlet var contentTextFields: [UITextField]!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var addButton: UIButton!
	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var addFunction: UIButton!
	@IBOutlet weak var functionLabel: UILabel!
	@IBOutlet weak var functionsStackView: UIStackView!
	
	let presenter: AddCompanyPresenter = AddCompanyPresenter()
	var coords: CLLocationCoordinate2D?
	var functionsTextFields: [UITextField] = []
	var activeTextField: UITextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		presenter.attachView(view: self)
		view.backgroundColor = .mainBackground
		
		setupLabels()
		setupTextFields()
		setupButtons()
		setupViews()
		NotificationCenter.default.addObserver(self, selector: #selector(_KeyboardHeightChanged(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(_KeyboardHeightChanged(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
			NotificationCenter.default.addObserver(self, selector: #selector(_KeyboardHeightChanged(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
			
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
	}
	
	@IBAction func addFunctionPressed(_ sender: Any) {
		let textField = ClockSystemTextField()
		textField.font = .camptonBold(ofSize: 20)
		textField.layer.borderWidth = 1
		textField.layer.borderColor = UIColor.descLabelColor.cgColor
		textField.textColor = .black
		textField.layer.cornerRadius = 20
		textField.layer.masksToBounds = true
		textField.delegate = self
		textField.frame = nameTextField.frame
		let height = nameTextField.frame.height
		textField.heightAnchor.constraint(equalToConstant: height).isActive = true
		
		functionsTextFields.append(textField)
		functionsStackView.addArrangedSubview(textField)
	}
}

private extension AddCompanyViewController {
	func setupLabels() {
		contentLabels.forEach { label in
			label.font = .camptonBook(ofSize: 15)
			label.textColor = .descLabelColor
		}
		
		titleLabel.text = "Add a company"
		titleLabel.font = .camptonBold(ofSize: 20)
		titleLabel.textColor = .white
		
		nameLabel.text = "Name"
		locationLabel.text = "Location"
		functionLabel.text = "Functions"
	}
	
	func setupTextFields() {
		contentTextFields.forEach { textField in
			textField.font = .camptonBold(ofSize: 20)
			textField.layer.borderWidth = 1
			textField.layer.borderColor = UIColor.descLabelColor.cgColor
			textField.setLeftPaddingPoints(10)
			textField.setRightPaddingPoints(10)
			textField.textColor = .black
			textField.layer.cornerRadius = 20
			textField.layer.masksToBounds = true
			textField.delegate = self
		}
	}
	
	func setupButtons() {
		backButton.setImage(#imageLiteral(resourceName: "icons8-back").withRenderingMode(.alwaysTemplate), for: .normal)
		backButton.tintColor = .white
		backButton.setTitle("", for: .normal)
		backButton.addTarget(self, action: #selector(navigateBack), for: .touchUpInside)
		
		addButton.setTitle("Add", for: .normal)
		addButton.setTitleColor(.white, for: .normal)
		addButton.backgroundColor = .mainBackground
		addButton.layer.cornerRadius = 20
		addButton.layer.masksToBounds = true
		addButton.addTarget(self, action: #selector(addCompany), for: .touchUpInside)
	}
	
	func setupViews() {
		contentView.backgroundColor = .white
		contentView.layer.cornerRadius = 25
	}
	
	@objc func navigateBack() {
		dismiss(animated: true, completion: nil)
	}
	
	
}

