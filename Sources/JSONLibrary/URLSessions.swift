//
//  URLSessions.swift
//  
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import Foundation

public extension URLSession {
	/// Función extendida de `URLSession` en su variante con `URL` con gestión de errores propios de tipo ``NetworkError``.
	///
	/// Función personalizada para realizar la llamada de red al recibir una `URL` como parámetro. Gestión de errores personalizados a través del tipo propio ``NetworkError``. La respuesta por defecto obtenida en la llamada se procesa para su devolución como `HTTPURLResponse`.
	///
	/// - Parameter url: Dirección `URL` del servidor para conformar la sesión de red y a la que se dirige la llamada.
	/// - Returns: Tupla de valores devueltos por la sesión de red, de tipo (`Data`, `HTTPURLResponse`).
	/// - Throws: Error de tipo ``NetworkError``.
	func getData(from url: URL) async throws -> (data: Data, response: HTTPURLResponse) {
		try await getData(for: URLRequest(url: url))
	}
	
	/// Función extendida de `URLSession` en su variante con `URLRequest` con gestión de errores propios de tipo ``NetworkError``.
	///
	/// Función personalizada para realizar la llamada de red al recibir una petición `URLRequest` como parámetro. Gestión de errores personalizados a través del tipo propio ``NetworkError``. La respuesta por defecto obtenida en la llamada se procesa para su devolución como `HTTPURLResponse`.
	///
	/// - Parameter request: Petición `URLRequest` para conformar la sesión de red y a la que se dirige la llamada.
	/// - Returns: Tupla de valores devueltos por la sesión de red, de tipo (`Data`, `HTTPURLResponse`).
	/// - Throws: Error de tipo ``NetworkError``.
	func getData(for request: URLRequest) async throws -> (data: Data, response: HTTPURLResponse) {
		do {
			let (data, response) = try await data(for: request)
			guard let response = response as? HTTPURLResponse else { throw NetworkError.nonHTTP }
			return (data, response)
		} catch let error as NetworkError {
			throw error
		} catch {
			throw NetworkError.general(error)
		}
	}
}
