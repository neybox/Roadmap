//
//  Button.swift
//  Roadmap
//
//  Created by Dickie on 21/10/2024.
//

import SwiftUI

extension Button {
	func debounce(isDebouncing: Binding<Bool>, for interval: TimeInterval = 1.0) -> some View {
		self.buttonStyle(DebounceButtonStyle(isDebouncing: isDebouncing, interval: interval))
	}
}

// Extension to make the modifier easier to use
extension View {
	func accessibleDebounce(isDebouncing: Binding<Bool>, for interval: TimeInterval = 1.0) -> some View {
		modifier(AccessibleDebounceModifier(isDebouncing: isDebouncing, interval: interval))
	}
}
