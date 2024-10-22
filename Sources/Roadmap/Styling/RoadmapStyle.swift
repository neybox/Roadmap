//
//  RoadmapStyle.swift
//
//
//  Created by Hidde van der Ploeg on 20/02/2023.
//
import Foundation
import SwiftUI
import Combine

//public class RoadmapThemeStyleModel: ObservableObject {
//	@Published var isDarkTheme: Bool?
//	private var binding: Binding<Bool?>
//	private var cancellables = Set<AnyCancellable>()
//	
//	init(binding: Binding<Bool?>) {
//		self.binding = binding
//		self.isDarkTheme = binding.wrappedValue
//		
//		// Observe the binding's value
//		self.binding.wrappedValue = self.isDarkTheme
//	
//		// Observe changes to isDarkTheme and update binding
//		$isDarkTheme
//			.receive(on: DispatchQueue.main)
//			.sink { [weak self] newValue in
//				print("~~~isDarkTheme changed to: \(String(describing: newValue))")
//				self?.binding.wrappedValue = newValue
//			}
//			.store(in: &cancellables)
//			
//		// Create a publisher from the binding and observe its changes
//		Timer.publish(every: 0.1, on: .main, in: .common)
//			.autoconnect()
//			.sink { [weak self] _ in
//				guard let self = self else { return }
//				let bindingValue = self.binding.wrappedValue
//				if self.isDarkTheme != bindingValue {
//					print("~~~Binding changed to: \(String(describing: bindingValue))")
//					self.isDarkTheme = bindingValue
//				}
//			}
//			.store(in: &cancellables)
//	}
//}

public class RoadmapThemeStyleModel: ObservableObject {
	@Published var isDarkTheme: Bool?
	private var binding: Binding<Bool?>

	init(binding: Binding<Bool?>) {
		self.binding = binding
		self.isDarkTheme = binding.wrappedValue
		
		// This ensures two-way binding
		self.binding = Binding(
			get: { [weak self] in
				self?.isDarkTheme
			},
			set: { [weak self] newValue in
				self?.isDarkTheme = newValue
			}
		)
	}
}

public struct RoadmapStyle {
    /// The image used for the upvote button
    public var upvoteIcon: Image
    
    /// The image used for the unvote button
    public var unvoteIcon: Image
    
    /// The font used for the feature
    public var titleFont: Font
	
	/// The font used for the description
	public var descriptionFont: Font
    
    /// The font used for the count label
    public var numberFont: Font
    
    /// The font used for the status views
    public var statusFont: Font
	
	/// The text colour for the feature title
	public var titleColor: Color
	
	/// The text colour for the feature description
	public var descriptionColor: Color
	
	/// The text color of the status
	public var statusColor: Color
    
    /// The tint color of the status view
    public var statusTintColor: Color
    
    /// The corner radius for the upvote button
    public var radius: CGFloat
    
    /// The backgroundColor of each cell for light mode
    public var cellColorLight: Color
	
	/// The backgroundColor of each cell for dark mode
	public var cellColorDark: Color
	
	/// The backgroundColor of each cell for light mode
	public var voteButtonBGColorLight: Color
	
	/// The backgroundColor of each cell for dark mode
	public var voteButtonBGColorDark: Color
    
    /// The color of the text and icon when voted
    public var selectedForegroundColor: Color
    
    /// The main tintColor for the roadmap views.
    public var tintColor: Color
    
    /// Define a `RoadmapStyle` to customise Roadmap to your needs
    /// - Parameters:
    ///   - upvoteIcon: Image view that you want to use for the upvote icon 24x24 of size is best
    ///   - unvoteIcon: Image view that you want to use for the upvote icon 24x24 of size is best
    ///   - titleFont: The font you want
    ///   - numberFont: The font used for the count label
    ///   - statusFont: The font used for the status views
    ///   - statusTintColor: The tint color of the status view
    ///   - cornerRadius: The corner radius for the upvote button
    ///   - cellColor: The backgroundColor of each cell
    ///   - selectedColor: The color of the text and icon when voted
    ///   - tint: The main tintColor for the roadmap views.
    public init(upvoteIcon: Image,
                unvoteIcon: Image,
                titleFont: Font,
				descriptionFont: Font,
                numberFont: Font,
                statusFont: Font,
				titleColor: Color = Color.primary,
				descriptionColor: Color = Color.secondary,
				statusColor: Color = Color.secondary,
				statusTintColor: Color = Color.primary,
                cornerRadius: CGFloat,
                cellColorLight: Color = Color.defaultCellColor,
				cellColorDark: Color = Color.defaultCellColor,
				voteButtonBGColorLight: Color = Color.defaultCellColor,
				voteButtonBGColorDark: Color = Color.defaultCellColor,
                selectedColor: Color = .white,
                tint: Color = .accentColor)
    {
        self.upvoteIcon = upvoteIcon
        self.unvoteIcon = unvoteIcon
        self.titleFont = titleFont
		self.descriptionFont = descriptionFont
        self.numberFont = numberFont
        self.statusFont = statusFont
		self.titleColor = titleColor
		self.descriptionColor = descriptionColor
		self.statusColor = statusColor
        self.statusTintColor = statusTintColor
        self.radius = cornerRadius
		self.cellColorLight = cellColorLight
		self.cellColorDark = cellColorDark
		self.voteButtonBGColorLight = voteButtonBGColorLight
		self.voteButtonBGColorDark = voteButtonBGColorDark
        self.selectedForegroundColor = selectedColor
        self.tintColor = tint
    }
}
