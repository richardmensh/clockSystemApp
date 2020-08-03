//
//  ClockSystemManager.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 25/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import Foundation
import Moya

class ClockSystemManager {
	static let shared = ClockSystemManager()
	
	let provider = MoyaProvider<ClockSystemApi>()
	var initUrl = ""
	
	func getCompanies(target: ClockSystemApi, completion: @escaping ([Company]?, Error?) -> ()) {
		provider.request(target) { json in
			switch json {
			case .success(let response):
				do {
					if let json = try response.mapJSON() as? NSArray {
						let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
						let results: [Company] = try JSONDecoder().decode([Company].self, from: data)
						completion(results, nil)
					}
				} catch let error {
					print(error.localizedDescription)
					completion(nil, error)
				}
			case .failure(let error):
				do {
					completion(nil, error)
				}
			}
		}
	}
	
	func getCompany(target: ClockSystemApi, completion: @escaping (Company?, Error?) -> ()) {
		provider.request(target) { json in
			switch json {
			case .success(let response):
				do {
					if let json = try response.mapJSON() as? [String: Any] {
						let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
						let result: Company = try JSONDecoder().decode(Company.self, from: data)
						completion(result, nil)
					}
				} catch let error {
					print(error.localizedDescription)
					completion(nil, error)
				}
			case .failure(let error):
				do {
					completion(nil, error)
				}
			}
		}
	}
	
	func getEvents(target: ClockSystemApi, completion: @escaping ([Event]?, Error?) -> ()) {
		provider.request(target) { json in
			switch json {
			case .success(let response):
				do {
					if let json = try response.mapJSON() as? NSArray {
						let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
						let results: [Event] = try JSONDecoder().decode([Event].self, from: data)
						completion(results, nil)
					}
				} catch let error {
					print(error.localizedDescription)
					completion(nil, error)
				}
			case .failure(let error):
				do {
					print(error.localizedDescription)
					completion(nil, error)
				}
			}
		}
	}
	
	func addEvent(target: ClockSystemApi, completion: @escaping (Event?, Error?) -> ()) {
		provider.request(target) { json in
			switch json {
			case .success(let response):
				do {
					if let json = try response.mapJSON() as? [String: Any] {
						let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
						let results: Event = try JSONDecoder().decode(Event.self, from: data)
						completion(results, nil)
					}
				} catch let error {
					print(error.localizedDescription)
					completion(nil, error)
				}
			case .failure(let error):
				do {
					completion(nil, error)
				}
			}
		}
	}
	
	func addCompany(target: ClockSystemApi, completion: @escaping (Company?, Error?) -> ()) {
		provider.request(target) { json in
			switch json {
			case .success(let response):
				do {
					if let json = try response.mapJSON() as? [String: Any] {
						let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
						let results: Company = try JSONDecoder().decode(Company.self, from: data)
						completion(results, nil)
					}
				} catch let error {
					print(error.localizedDescription)
					completion(nil, error)
				}
			case .failure(let error):
				do {
					completion(nil, error)
				}
			}
		}
	}
	
	func deleteObject(target: ClockSystemApi, completion: @escaping (Bool?, Error?) -> ()) {
		provider.request(target) { json in
			switch json {
			case .success(let response):
				do {
					if response.statusCode == 200 {
						completion(true, nil)
					}
				} catch let error {
					print(error.localizedDescription)
					completion(nil, error)
				}
			case .failure(let error):
				do {
					completion(nil, error)
				}
			}
		}
	}
	func deleteCompany(target: ClockSystemApi, completion: @escaping (Company?, Error?) -> ()) {
		provider.request(target) { json in
			switch json {
			case .success(let response):
				do {
					if let json = try response.mapJSON() as? [String: Any] {
						let data = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
						let results: Company = try JSONDecoder().decode(Company.self, from: data)
						completion(results, nil)
					}
				} catch let error {
					print(error.localizedDescription)
					completion(nil, error)
				}
			case .failure(let error):
				do {
					completion(nil, error)
				}
			}
		}
	}
}
