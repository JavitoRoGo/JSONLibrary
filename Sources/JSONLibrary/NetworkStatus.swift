//
//  NetworkStatus.swift
//
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import Network
import SwiftUI

public final class NetworkStatus: ObservableObject {
	public enum Status {
		case offline, online, unknown
	}
	
	@Published var status: Status = .online
	
	let monitor = NWPathMonitor()
	var queue = DispatchQueue(label: "MonitorNetwork")
	
	init() {
		monitor.start(queue: queue)
		monitor.pathUpdateHandler = { [self] path in
			DispatchQueue.main.async {
				self.status = path.status != .unsatisfied ? .online : .offline
			}
		}
	}
}
