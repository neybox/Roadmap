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
