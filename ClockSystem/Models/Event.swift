//
//  Event.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 18/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import Foundation

class Event: Codable {
	let id: String!
	let companyId: String!
	let eventDate: String!
	let role: String!
	var clockIn: String!
	var clockOut: String!
	var rate: String?
	var description: String?
	
	private enum CodingKeys: String, CodingKey {
		case id = "_id"
		case companyId
		case eventDate
		case role
		case clockIn
		case clockOut
		case rate
		case description
	}
}

