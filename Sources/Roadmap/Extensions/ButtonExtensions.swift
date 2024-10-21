//
//  Button.swift
//  Roadmap
//
//  Created by Dickie on 21/10/2024.
//

import SwiftUI

extension Button {
	func debounce(for interval: TimeInterval = 1.0) -> some View {
		self.buttonStyle(DebounceButtonStyle(interval: interval))
	}
}
