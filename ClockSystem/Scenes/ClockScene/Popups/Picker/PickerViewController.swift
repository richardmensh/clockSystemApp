//
//  PickerViewController.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 01/08/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
	
	var data: [String]?
	@IBOutlet weak var doneButton: UIButton!
	@IBOutlet weak var pickerView: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		pickerView.dataSource = self
		pickerView.delegate = self
		view.backgroundColor = .white
		
		let selectedData = data?.first ?? ""
		NotificationCenter.default.post(name: .didSelectFuntion, object: nil, userInfo: ["function": selectedData])
		
		doneButton.layer.cornerRadius = 25
		doneButton.backgroundColor = .mainBackground
		doneButton.setTitle("Done", for: .normal)
    }
	
	@IBAction func doneButtonPressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return data?.count ?? 0
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return data?[row] ?? ""
	}
	
	func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

		let string = data?[row] ?? ""
		return NSAttributedString(string: string, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
	}
	 
	func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
		return 40
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let selectedData = data?[row] ?? ""
		NotificationCenter.default.post(name: .didSelectFuntion, object: nil, userInfo: ["function": selectedData])
	}
	
	
}
