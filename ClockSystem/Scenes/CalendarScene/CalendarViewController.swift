//
//  CalendarViewController.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 19/07/2020.
//  Copyright (c) 2020 ressemiah. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var calendarView: FSCalendar!
	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var eventTableView: UITableView!
	
	let presenter: CalendarPresenter = CalendarPresenter()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .mainBackground
		
		presenter.attachView(view: self)
		
		
		setupLabels()
		setupCalendar()
		setupButtons()
		setupTableView()
		
		presenter.getEvents()
	}	
}

private extension CalendarViewController {
	func setupLabels() {
		titleLabel.text = "Calendar"
		titleLabel.font = .camptonBold(ofSize: 20)
		titleLabel.textColor = .white
	}
	
	func setupButtons() {
		backButton.setImage(#imageLiteral(resourceName: "icons8-back").withRenderingMode(.alwaysTemplate), for: .normal)
		backButton.tintColor = .white
		backButton.setTitle("", for: .normal)
		backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
	}
	
	func setupTableView() {
		eventTableView?.register(EventTableViewCell.self)
		eventTableView?.delegate = self
		eventTableView?.dataSource = self
		eventTableView.separatorStyle = .none
		eventTableView.backgroundColor = .white
		eventTableView.estimatedRowHeight = 90
//		scheduleTableView.addSubview(self.refreshControl)
	}
	
	func setupCalendar() {
		calendarView.backgroundColor = .calendarColor
		calendarView.delegate = self
		calendarView.dataSource = self
		calendarView.layer.cornerRadius = 20
		calendarView.layer.masksToBounds = true
	}
	
	@objc func backButtonPressed() {
		presenter.backButtonPressed()
	}
}

