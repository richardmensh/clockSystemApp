//
//  CalendarActions.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 20/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import UIKit
import FSCalendar

extension CalendarViewController {
	func getEventsFromDate(date: Date) {
		presenter.eventsOnADay = []
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy/MM/dd"
		dateFormatter.locale = Locale.init(identifier: "nl-NL")
		_ = presenter.events.forEach { event in
			let eventDateTimeStamp = event.eventDate ?? ""
			let dateDouble = Double(eventDateTimeStamp)
			let eventDate = Date(timeIntervalSince1970: dateDouble ?? 0)
			
			if dateFormatter.string(from: date) == dateFormatter.string(from: eventDate) {
				presenter.eventsOnADay.append(event)
			}
		}
		eventTableView.reloadData()
	}
}

extension CalendarViewController: CalendarPresenterProtocol {
	func navigateBack() {
		let transition: CATransition = CATransition()
		transition.duration = 0.5
		transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
		transition.type = .reveal
		transition.subtype = .fromBottom
		self.view.window!.layer.add(transition, forKey: nil)
		self.dismiss(animated: false, completion: nil)
	}
	
	func obtainEvents() {
		getEventsFromDate(date: Date())
		calendarView.reloadData()
	}
	
	func obtainCompany() {
		eventTableView.reloadData()
	}
}

extension CalendarViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.eventsOnADay.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: EventTableViewCell = tableView.dequeueReusableCell(for: indexPath)
		let event = presenter.eventsOnADay[indexPath.row]
		let companies = presenter.companies
		companies.forEach { company in
			if event.companyId == company.id {
				cell.config(event: event, company: company)
			}
		}
		
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 80
	}
		
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
	func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy/MM/dd"
		dateFormatter.locale = Locale.init(identifier: "nl-NL")
		let datesString = presenter.events.map { $0.eventDate ?? ""}
		
		var dates: [Date] = []
		_ = datesString.map {
			let dateDouble = Double($0)
			let date = Date(timeIntervalSince1970: dateDouble ?? 0)
			dates.append(date)
		}
		for dateStr in dates {
			let strDate = dateFormatter.string(from: dateStr)
			if(dateFormatter.string(from: date) == strDate) {
				
				return 1
			}
		}
		return 0
	}
	
	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		 getEventsFromDate(date: date)
	}
}
