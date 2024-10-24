//
//  File.swift
//  Roadmap
//
//  Created by Dickie on 21/10/2024.
//

import SwiftUI
import Combine

struct DebounceButtonStyle: ButtonStyle {
	@Binding var isDebouncing: Bool
	let interval: TimeInterval
	
	init(isDebouncing: Binding<Bool>, interval: TimeInterval = 1.0) {
		self._isDebouncing = isDebouncing
		self.interval = interval
	}
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
//			.onChange(of: configuration.isPressed) { isPressed in
//				if isPressed && !isDebouncing {
//					isDebouncing = true
//					DispatchQueue.main.asyncAfter(deadline: .now() + interval) {
//						isDebouncing = false
//					}
//				}
//			}
	}
}
