//
//  RoadmapVoteButton.swift
//
//
//  Created by Hidde van der Ploeg on 20/02/2023.
//

import SwiftUI

struct RoadmapVoteButton: View {
    @ObservedObject var viewModel: RoadmapFeatureViewModel
    @Environment(\.dynamicTypeSize) var typeSize
	@Environment(\.colorScheme) var colorScheme: ColorScheme
	
    @State private var isHovering = false
    @State private var showNumber = false
    @State private var hasVoted = false
	@State private var id = UUID()
	    
    var body: some View {
        Button {
			if viewModel.canVote && viewModel.configuration.voter.canVote(for: viewModel.feature) {
                Task {
                    if !viewModel.hasVoted {
                        await viewModel.vote()
                    } else {
                        await viewModel.unvote()
                    }
                    #if os(iOS)
                    let haptic = UIImpactFeedbackGenerator(style: .soft)
                    haptic.impactOccurred()
                    #endif
                }
            }
        } label: {
            ZStack {
                if typeSize.isAccessibilitySize {
                    HStack(spacing: isHovering ? 2 : 0) {
                        if viewModel.canVote {
                            if !viewModel.hasVoted {
                                viewModel.configuration.style.upvoteIcon
									.accessibility(hidden: true)
                                    .foregroundColor(hasVoted ? viewModel.configuration.style.selectedForegroundColor : viewModel.configuration.style.tintColor)
                                    .imageScale(.large)
                                    .font(Font.system(size: 17, weight: .medium))
                                    .frame(maxWidth: 24, maxHeight: 24)
                            } else {
                                viewModel.configuration.style.unvoteIcon
									.accessibility(hidden: true)
                                    .foregroundColor(hasVoted ? viewModel.configuration.style.selectedForegroundColor : viewModel.configuration.style.tintColor)
                                    .imageScale(.large)
                                    .font(Font.system(size: 17, weight: .medium))
                                    .frame(maxWidth: 24, maxHeight: 24)
                            }
                        }
                        
                        if showNumber {
                            Text("\(viewModel.voteCount)")
								.accessibility(hidden: true)
                                .lineLimit(1)
                                .foregroundColor(hasVoted ? viewModel.configuration.style.selectedForegroundColor : viewModel.configuration.style.tintColor)
                                .minimumScaleFactor(0.5)
                                .font(viewModel.configuration.style.numberFont)
                        }
                    }
					.accessibility(hidden: true)
                    .padding(viewModel.configuration.style.radius)
                    .frame(minHeight: 64)
                    .background(backgroundView)
                } else {
                    VStack(spacing: isHovering ? 6 : 4) {
                        if viewModel.canVote {
                            if !viewModel.hasVoted {
                                viewModel.configuration.style.upvoteIcon
									.accessibility(hidden: true)
									.accessibilityLabel(Text(""))
                                    .foregroundColor(hasVoted ? viewModel.configuration.style.selectedForegroundColor : viewModel.configuration.style.tintColor)
                                    .imageScale(.large)
                                    .font(viewModel.configuration.style.numberFont)
                                    .frame(maxWidth: 20, maxHeight: 20)
                                    .minimumScaleFactor(0.75)
                            } else {
                                viewModel.configuration.style.unvoteIcon
									.accessibility(hidden: true)
									.accessibilityLabel(Text(""))
                                    .foregroundColor(hasVoted ? viewModel.configuration.style.selectedForegroundColor : viewModel.configuration.style.tintColor)
                                    .imageScale(.large)
                                    .font(viewModel.configuration.style.numberFont)
                                    .frame(maxWidth: 20, maxHeight: 20)
                                    .minimumScaleFactor(0.75)
                            }
                        }
                        
                        if showNumber {
                            Text("\(viewModel.voteCount)")
								.accessibility(hidden: true)
                                .lineLimit(1)
                                .foregroundColor(hasVoted ? viewModel.configuration.style.selectedForegroundColor : viewModel.configuration.style.tintColor)
                                .font(viewModel.configuration.style.numberFont)
                                .minimumScaleFactor(0.9)
                        }
                    }
					.accessibilityElement(children: .ignore)
					.accessibility(hidden: true)
                    .frame(minWidth: 56)
                    .frame(height: 64)
                    .background(backgroundView)
                }
            }
			.accessibility(hidden: true)
            .contentShape(RoundedRectangle(cornerRadius: viewModel.configuration.style.radius, style: .continuous))
            .overlay(overlayBorder)
        }
        .buttonStyle(.plain)
		.debounce(for: 1.0)
		.disabled(!viewModel.canVote || !viewModel.configuration.voter.canVote(for: viewModel.feature))
		.id(id)
		.onChange(of: viewModel.configuration.hasReachedVoteLimit.wrappedValue) { _ in
			id = UUID()
		}
        .onChange(of: viewModel.voteCount) { newCount in
            if newCount > 0 {
                withAnimation(.spring(response: 0.45, dampingFraction: 0.4, blendDuration: 0)) {
                    showNumber = true
                }
            }
        }
        .onChange(of: viewModel.hasVoted) { newVote in
            withAnimation(.spring(response: 0.45, dampingFraction: 0.4, blendDuration: 0)) {
                hasVoted = newVote
            }
        }
        .onHover { newHover in
            if viewModel.canVote && !hasVoted {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0)) {
                    isHovering = newHover
                }
            }
        }
        .onAppear {
            showNumber = viewModel.voteCount > 0
			hasVoted = viewModel.configuration.voter.hasVoted(for: viewModel.feature)
            withAnimation(.spring(response: 0.45, dampingFraction: 0.4, blendDuration: 0)) {
                hasVoted = viewModel.hasVoted
            }
        }
		.accessibilityLabel(viewModel.canVote ? !viewModel.hasVoted
							? Text("Vote for \(viewModel.feature.localizedFeatureTitle)")
							: Text("Remove vote for \(viewModel.feature.localizedFeatureTitle)") : Text(""))
		.accessibilityAddTraits(.isButton)
        .animateAccessible()
        .accessibilityShowsLargeContentViewer()
    }
    
    @ViewBuilder
    var overlayBorder: some View {
        if isHovering {
            RoundedRectangle(cornerRadius: viewModel.configuration.style.radius, style: .continuous)
                .stroke(viewModel.configuration.style.tintColor, lineWidth: 1)
        }
    }
    
	@ViewBuilder
    private var backgroundView: some View {
		if hasVoted {
			viewModel.configuration.style.tintColor
				.clipShape(RoundedRectangle(cornerRadius: viewModel.configuration.style.radius, style: .continuous))
		} else {
			if isDarkTheme() {
				viewModel.configuration.style.voteButtonBGColorDark
					.clipShape(RoundedRectangle(cornerRadius: viewModel.configuration.style.radius, style: .continuous))
			} else {
				viewModel.configuration.style.voteButtonBGColorLight
					.clipShape(RoundedRectangle(cornerRadius: viewModel.configuration.style.radius, style: .continuous))
			}
		}
    }
	
	private func isDarkTheme() -> Bool {
		if let isDarkTheme = viewModel.configuration.style.isDarkTheme.wrappedValue {
			return isDarkTheme
		}
		return colorScheme == .dark
	}
}
