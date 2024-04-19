//
//  UnavailableNetwork.swift
//
//
//  Created by Javier Rodríguez Gómez on 19/4/24.
//

import SwiftUI

fileprivate struct UnavailableNetwork: ViewModifier {
	let status: NetworkStatus.Status
	let errorTitle: String
	let errorMessage: String
	
	func body(content: Content) -> some View {
		content
			.overlay {
				ZStack {
					Rectangle()
						.fill(.ultraThinMaterial)
					
					ContentUnavailableView(errorTitle, systemImage: "network.slash", description: Text(errorMessage))
				}
				.frame(maxWidth: .infinity, maxHeight: .infinity)
				.ignoresSafeArea()
				.opacity(status == .online ? 0.0 : 1.0)
			}
			.animation(.default, value: status)
	}
}

public extension View {
	func unavailableNetwork(status: NetworkStatus.Status, errorTitle: String, errorMessage: String) -> some View {
		modifier(UnavailableNetwork(status: status, errorTitle: errorTitle, errorMessage: errorMessage))
	}
}
