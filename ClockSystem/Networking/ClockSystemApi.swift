//
//  ClockSystemApi.swift
//  ClockSystem
//
//  Created by Richard Essemiah on 25/07/2020.
//  Copyright © 2020 ressemiah. All rights reserved.
//

import Foundation
import Moya

enum ClockSystemApi {
	case companies
	case getCompany(id: String)
	case addCompany(data: [String: Any])
	case deleteCompany(id: String)
	case events
	case addEvent(data: [String: Any])
	case getEvent(id: String)
	case deleteEvent(id: String)
}

extension ClockSystemApi: TargetType {
	var baseURL: URL {
		return URL(string: "https://clocksysteem.herokuapp.com/")!
	}
	
	var path: String {
		switch self {
		case .companies, .addCompany, .deleteCompany:
			return "companies"
		case .getCompany(let id):
			return "companies/\(id)"
		case .events, .addEvent, .deleteEvent:
			return "events"
		case .getEvent(id: let id):
			return "events/\(id)"
			
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .companies, .events, .getEvent, .getCompany:
			return .get
		case .addEvent, .addCompany:
			return .post
		case .deleteCompany, .deleteEvent:
			return .delete
		}
	}
	
	///JSONencoding.
	var parameterEncoding: ParameterEncoding {
		return JSONEncoding()
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .companies, .events, .getCompany, .getEvent:
			return .requestPlain
		case .deleteCompany(let id), .deleteEvent(let id):
			let parameters: [String: Any] = ["_id": id]
			return  .requestParameters(parameters: parameters, encoding: parameterEncoding)
			
		case .addEvent(let data), .addCompany(let data):
			var parameters = [:] as [String : Any]
			data.forEach {
				let key = $0.key
				let value = $0.value
				parameters[key] = value
			}
			return  .requestParameters(parameters: parameters, encoding: parameterEncoding)
			
		}
	}
	
	var headers: [String : String]? {
		return ["Content-Type": "application/json"]
	}
}
