//
//  URLSessions.swift
//  
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import Foundation

public extension URLSession {
	func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
		do {
			let (data, response) = try await URLSession.shared.data(from: url)
			guard let response = response as? HTTPURLResponse else { throw NetworkError.nonHTTP }
			return (data, response)
		} catch let error as NetworkError {
			throw error
		} catch {
			throw NetworkError.general(error)
		}
	}
	
	func getData(for request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
		do {
			let (data, response) = try await URLSession.shared.data(for: request)
			guard let response = response as? HTTPURLResponse else { throw NetworkError.nonHTTP }
			return (data, response)
		} catch let error as NetworkError {
			throw error
		} catch {
			throw NetworkError.general(error)
		}
	}
}
