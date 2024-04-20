//
//  NetworkError.swift
//
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import Foundation

/// Enumeración con los distintos posibles errores que pueden darse en las llamadas de red.
public enum NetworkError: LocalizedError {
	/// Error de tipo general, que captura el error de la operación que lo provoca.
	case general(Error)
	/// Error asociado a la respuesta `HTTPURLResponse`, que captura un valor entero asociado al `statusCode`.
	case status(Int)
	/// Error asociado al parseo del archivo `JSON`, que captura el error de la operación que lo genera.
	case json(Error)
	/// Error en los datos recuperados de la llamada a red.
	case dataNotValid
	/// Error en la llamada si no se puede establecer una conexión `HTTP`.
	case nonHTTP
	/// Error desconocido.
	case unknown
	
	public var errorDescription: String? {
		switch self {
			case .general(let error):
				"A general error has occurred: \(error.localizedDescription)."
			case .status(let int):
				"A status code error has occurred: \(int)."
			case .json(let error):
				"A JSON error has occurred: \(error.localizedDescription)."
			case .dataNotValid:
				"Data not valid, an error has occurred."
			case .nonHTTP:
				"This is not a HTTP connection."
			case .unknown:
				"Unknown error."
		}
	}
}
