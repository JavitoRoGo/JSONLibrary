//
//  NetworkError.swift
//
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import Foundation

public enum NetworkError: LocalizedError {
	case general(Error)
	case status(Int)
	case json(Error)
	case dataNotValid
	case nonHTTP
	
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
		}
	}
}
