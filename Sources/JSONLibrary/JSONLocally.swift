//
//  JSONLocally.swift
//
//
//  Created by Javier Rodríguez Gómez on 18/4/24.
//

import Foundation

/// Protocolo al que conformar el `struct` de la `app` responsable de la persistencia de los datos en local.
///
/// Este protocolo proporciona las propiedades necesarias para la persistencia de los datos en local:
///
/// - ``bundleURL``
/// - ``docURL``
public protocol URLInteractor {
	/// Propiedad que contiene la ubicación del archivo `JSON` con los datos en el `Bundle`.
	var bundleURL: URL { get }
	/// Propiedad que contiene la ubicación del archivo `JSON` con los datos en la carpeta de documentos de la `app`.
	var docURL: URL { get }
}

/// Protocolo al que conformar el `struct` de la `app` responsable de la persistencia de los datos en local.
///
/// Este protocolo proporciona las funciones necesarias para la persistencia de los datos en local:
///
/// - ``getFromJSON(url:type:)-rykc`` para recuperar los datos.
/// - ``saveToJSON(url:datas:)-37hyc`` para guardar los datos.
///
/// La implementación de ambas funciones se proporciona a través de una extensión.
public protocol JSONInteractor {
	///Función que recupera los datos desde un archivo en local y los convierte en un tipo de dato `Codable`.
	///
	/// Función utilizada para la persistencia con archivos JSON en local. Su objetivo es recuperar los datos desde una ubicación específica, indicada en el parámetro `url`, y convertirlos a un tipo de dato conformado a `Codable`.
	/// ```swift
	/// let yourData = try getFromJSON(url: yourURL, type: YourType.self)
	/// ```
	///
	/// - Parameters:
	///   - url: Dirección `URL` del archivo `JSON` en local que contiene los datos.
	///   - type: Tipo de dato al que convertir el contenido del archivo `JSON`. Debe estar conformado a `Codable`.
	/// - Returns:La función devuelve los datos del `JSON` ya convertidos al tipo indicado en el parámetro `type`.
	/// - Throws: La función puede lanzar dos tipos de errores: al transformar a `Data` el contenido de la  `url`, y al decodificar los datos en bruto al tipo `T`.
	func getFromJSON<T>(url: URL, type: T.Type) throws -> T where T: Codable
	
	/// Función que guarda en local los datos de tipo `Codable` especificados.
	///
	///Función utilizada para la persistencia con archivos `JSON` en local. Su objetivo es guardar los datos indicados en un archivo `JSON` en local. El proceso de escritura del archivo en local se hace usando las opciones `.atomic` para garantizar que el archivo no se corrompa.
	///```swift
	///try saveToJSON(url: yourURL, datas: yourData)
	///```
	///
	/// - Parameters:
	///   - url: Dirección `URL` del archivo `JSON` en local donde se guardarán los datos.
	///   - datas: Datos a guardar en local en el fichero `JSON`. Deben estar conformados a `Codable`.
	/// - Throws: La función puede lanzar un error durante la transformación de nuestros datos en su representación en el tipo `Data`.
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
