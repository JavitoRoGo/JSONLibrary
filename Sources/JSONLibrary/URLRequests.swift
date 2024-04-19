//
//  URLRequests.swift
//
//
//  Created by Javier Rodríguez Gómez on 18/4/24.
//

import Foundation

public extension URLRequest {
	static func get(url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = "GET"
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
	
	static func post<T>(url: URL, datas: T, method: HTTPMethod = .post) -> URLRequest where T: Codable {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = method.rawValue
		request.httpBody = try? JSONEncoder().encode(datas)
		request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
}

public enum HTTPMethod: String {
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
	case patch = "PATCH"
}
