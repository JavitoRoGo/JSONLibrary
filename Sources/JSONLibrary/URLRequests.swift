//
//  URLRequests.swift
//
//
//  Created by Javier Rodríguez Gómez on 18/4/24.
//

import Foundation

public extension URLRequest {
	/// Función para las peticiones de tipo `GET` al servidor.
	///
	/// Función personalizada para usar como un método propio de `URLRequest` para realizar peticiones de tipo `GET` al servidor. Configurada por defecto con un `timeout` de 60 segundos, y enviando en la cabecera la aceptación del manejo de `JSON`.
	///
	/// - Parameter url: Dirección `URL` del servidor para conformar la petición y a la que se dirige dicha petición.
	/// - Returns: Instancia de `URLRequest` personalizada y que se enviará a la `URLSession`.
	static func get(url: URL) -> URLRequest {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = "GET"
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		return request
	}
	
	/// Función para las peticiones de tipo genérico `POST` al servidor.
	///
	/// Función personalizada para usar como un método propio de `URLRequest` para realizar peticiones de tipo genérico `POST` al servidor. Puede definirse para realizar las operaciones de `POST`, `PUT`, `DELETE` y `PATCH`. Configurada por defecto con un `timeout` de 60 segundos, y enviando en la cabecera la aceptación del manejo de `JSON`.
	///
	/// - Parameters:
	///   - url: Dirección `URL` del servidor para conformar la petición y a la que se dirige el `post` o envío de información.
	///   - datas: Datos conformados a `Codable` que serán enviados en la petición.
	///   - method: Método ``HTTPMethod`` a utilizar en la petición. Si no se especifica, se toma el valor de la operación `POST` por defecto.
	/// - Returns: Instancia de `URLRequest` personalizada y que se enviará a la `URLSession`.
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

/// Tipo de método `HTTP` a utilizar en la operación de envío de información al servidor.
public enum HTTPMethod: String {
	case post = "POST"
	case put = "PUT"
	case delete = "DELETE"
	case patch = "PATCH"
}
