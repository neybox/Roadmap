//
//  File.swift
//  Roadmap
//
//  Created by Dickie on 21/10/2024.
//

import SwiftUI
import Combine

struct DebounceButtonStyle: ButtonStyle {
	@State private var isDebouncing = false
	let interval: TimeInterval
	
	init(interval: TimeInterval = 1.0) {
		self.interval = interval
	}
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.disabled(isDebouncing)
			.onChange(of: configuration.isPressed) { isPressed in
				if isPressed && !isDebouncing {
					isDebouncing = true
					DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
						isDebouncing = false
					}
				}
			}
	}
}
