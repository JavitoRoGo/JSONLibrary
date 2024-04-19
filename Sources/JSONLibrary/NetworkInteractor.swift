//
//  NetworkInteractor.swift
//
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import Foundation

public protocol NetworkInteractor {
	var session: URLSession { get }
	
	func getJSON<T>(request: URLRequest, type: T.Type) async throws -> T where T: Codable
	func postJSON(request: URLRequest) async throws
}

public extension NetworkInteractor {
	func getJSON<T>(request: URLRequest, type: T.Type) async throws -> T where T: Codable {
		let (data, response) = try await URLSession.shared.getData(for: request)
		if response.statusCode == 200 {
			do {
				return try JSONDecoder().decode(type, from: data)
			} catch {
				throw NetworkError.json(error)
			}
		} else {
			throw NetworkError.status(response.statusCode)
		}
	}
	
	func postJSON(request: URLRequest) async throws {
		let (_, response) = try await URLSession.shared.getData(for: request)
		if response.statusCode != 200 {
			throw NetworkError.status(response.statusCode)
		}
	}
}
