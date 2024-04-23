//
//  NetworkInteractor.swift
//
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import Foundation

/// Protocolo al que conformar el `struct` de la `app` responsable de la persistencia de los datos en la red.
///
/// Este protocolo proporciona las funciones necesarias para obtener y enviar datos a la red, a un servidor o una API:
///
/// - ``getJSON(request:type:)-89pay`` para petición de recuperación de los datos.
/// - ``postJSON(request:)-8ndgg`` para petición de envío de los datos.
///
/// La implementación de ambas funciones se proporciona a través de una extensión.
public protocol NetworkInteractor {
	/// Sesión personalizada de `URLSession` que se inicializará por defecto con el singleton `.shared`, pero permite la inyección de una sesión personalizada para los tests.
	var session: URLSession { get }
	
	/// Función que recupera los datos a través de una llamada de red.
	///
	/// Función utilizada para recuperar los datos a través de una llamada de red a un servidor o API. Su objetivo es recuperar los datos de la red usando una petición `URLRequest`, y devolviendo esos datos como un tipo conformado a `Codable`.
	/// ```swift
	/// let yourData = try await getJSON(request: yourRequest, type: YourType.self)
	/// ```
	/// - Parameters:
	///   - request: Petición de tipo `URLRequest` que a su vez contiene la `URL` a la que se hará la petición de los datos.
	///   - type: Tipo de dato al que convertir el contenido de la respuesta de la llamada de red. Debe estar conformado a `Codable`.
	/// - Returns: La función devuelve los datos de red ya convertidos al tipo indicado en el parámetro `type`.
	/// - Throws: Error de tipo ``NetworkError``.
	func getJSON<T>(request: URLRequest, type: T.Type) async throws -> T where T: Codable
	
	/// Función que hace una llamada de red y envía los datos especificados.
	///
	/// Función utilizada para hacer una llamada de red y enviar los datos en una petición, ya sea para guardarlos, actualizarlos, etc. Los datos, conformados a `Codable`, se incluyen en la petición `URLRequest` como parte del `httpBody`.
	/// ```swift
	/// try await postJSON(request: yourRequest)
	/// ```
	///
	/// - Parameter request: Petición de tipo `URLRequest` que a su vez contiene los datos y la `URL` a la que se hará la petición de envío.
	/// - Throws: Error de tipo ``NetworkError``.
	func postJSON(request: URLRequest) async throws
}

public extension NetworkInteractor {
	func getJSON<T>(request: URLRequest, type: T.Type) async throws -> T where T: Codable {
		let (data, response) = try await session.getData(for: request)
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
		let (_, response) = try await session.getData(for: request)
		if response.statusCode != 200 {
			throw NetworkError.status(response.statusCode)
		}
	}
}
