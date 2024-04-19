//
//  JSONLocally.swift
//
//
//  Created by Javier Rodríguez Gómez on 18/4/24.
//

import Foundation

public protocol URLInteractor {
	var bundleURL: URL { get }
	var docURL: URL { get }
}

public protocol JSONInteractor {
	func getFromJSON<T>(url: URL, type: T.Type) throws -> T where T: Codable
	func saveToJSON<T>(url: URL, datas: T) throws where T: Codable
}

public extension JSONInteractor {
	func getFromJSON<T>(url: URL, type: T.Type) throws -> T where T: Codable {
		let data = try Data(contentsOf: url)
		return try JSONDecoder().decode(type, from: data)
	}
	
	func saveToJSON<T>(url: URL, datas: T) throws where T: Codable {
		let data = try JSONEncoder().encode(datas)
		try data.write(to: url, options: .atomic)
	}
}
