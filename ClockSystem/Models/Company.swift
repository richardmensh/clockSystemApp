//
//  Company.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 25/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import Foundation

class Company: Codable {
	let id: String!
	let name: String!
	let functions: [String]!
	let address: String!
	var image: String?
	var remindMe: Bool? = false
	
	private enum CodingKeys: String, CodingKey {
		case id = "_id"
		case name
		case functions
		case address
		case  image
		case remindMe
	}
}
