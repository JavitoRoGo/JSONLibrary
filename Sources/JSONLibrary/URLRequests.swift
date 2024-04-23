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
	/// - Parameters:
	///   - url: Dirección `URL` del servidor para conformar la petición y a la que se dirige dicha petición.
	///   - token: Token opcional para la autorización.
	///   - authMethod: Método ``AuthMethod`` para la autorización. Se incluye en la cabecera solo si se proporciona un valor a `token`.
	/// - Returns: Instancia de `URLRequest` personalizada y que se enviará a la `URLSession`.
	static func get(url: URL, token: String? = nil, authMethod: AuthMethod = .token) -> URLRequest {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = "GET"
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		if let token {
			request.setValue("\(authMethod.rawValue) \(token)", forHTTPHeaderField: "Authorization")
		}
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
	///   - token: Token opcional para la autorización.
	///   - authMethod: Método ``AuthMethod`` para la autorización. Se incluye en la cabecera solo si se proporciona un valor a `token`.
	/// - Returns: Instancia de `URLRequest` personalizada y que se enviará a la `URLSession`.
	static func post<T>(url: URL, datas: T, method: HTTPMethod = .post, token: String? = nil, authMethod: AuthMethod = .token) -> URLRequest where T: Codable {
		var request = URLRequest(url: url)
		request.timeoutInterval = 60
		request.httpMethod = method.rawValue
		request.httpBody = try? JSONEncoder().encode(datas)
		request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
		request.setValue("application/json", forHTTPHeaderField: "Accept")
		if let token {
			request.setValue("\(authMethod.rawValue) \(token)", forHTTPHeaderField: "Authorization")
		}
		return request
	}
}


/// Tipo de método `HTTP` a utilizar en la operación de envío de información al servidor.
public enum HTTPMethod: String {
	/// Método para enviar datos para ser procesados.
	case post = "POST"
	
	/// Método para actualizar un registro, o crearlo si no existe.
	case put = "PUT"
	
	/// Método para borrado de registros.
	case delete = "DELETE"
	
	/// Método para modificar parcialmente un registro.
	case patch = "PATCH"
}


/// Tipo de autorización a utilizar en la operación de envío de información al servidor. Incluye los tipos más frecuentes.
public enum AuthMethod: String {
	/// Uso de token como método de autorización.
	case token = "Bearer"
	
	/// Uso de credenciales `username:password` como método de autorización.
	case basic = "Basic"
}
