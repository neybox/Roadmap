//
//  RoadmapThemeStyleModel.swift
//  Roadmap
//
//  Created by Dickie on 22/10/2024.
//

import Foundation
import Combine

public class RoadmapThemeStyleModel: ObservableObject {
	@Published var isDarkTheme: Bool?
	private var cancellables = Set<AnyCancellable>()
	
	init(themePublisher: AnyPublisher<Bool?, Never>) {
		themePublisher
			.receive(on: DispatchQueue.main)
			.sink { [weak self] newValue in
				self?.isDarkTheme = newValue
			}
			.store(in: &cancellables)
	}
}
