//
//  RoadmapFeatureView.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import SwiftUI

struct RoadmapFeatureView: View {
    @Environment(\.dynamicTypeSize) var typeSize
    @StateObject var viewModel: RoadmapFeatureViewModel
	
	private var featureTitleDecriptionAccessibilityLabel: String {
		let title = viewModel.feature.localizedFeatureTitle
		let description = viewModel.feature.localizedFeatureDescription
		let voteCount = viewModel.voteCount
		let status = viewModel.feature.localizedFeatureStatus

		var label = title

		if !description.isEmpty {
			label += ". " + description
		}

		label += ". Currently \(voteCount) " + (voteCount == 1 ? "vote" : "votes")
		
		if let status {
			label += ". Status: \(status)"
		}

		return label
	}

    var body: some View {
        ZStack{
            if typeSize.isAccessibilitySize {
                verticalCell
            } else {
                horizontalCell
            }
        }
        .background(viewModel.configuration.style.cellColor)
        .clipShape(RoundedRectangle(cornerRadius: viewModel.configuration.style.radius, style: .continuous))
        .task {
            await viewModel.getCurrentVotes()
        }
        
    }
    
    var horizontalCell : some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
				Text(viewModel.feature.localizedFeatureTitle)
					.font(viewModel.configuration.style.titleFont)
					.foregroundColor(viewModel.configuration.style.titleColor)
				
				let description = viewModel.feature.localizedFeatureDescription
				if !description.isEmpty {
					Text(description)
						.font(viewModel.configuration.style.numberFont)
						.foregroundColor(viewModel.configuration.style.descriptionColor)
				}

                if let localizedStatus = viewModel.feature.localizedFeatureStatus {
                    Text(localizedStatus)
                        .padding(6)
                        .background(viewModel.configuration.style.statusTintColor)
                        .foregroundColor(viewModel.configuration.style.statusColor)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
								.stroke(Color("blackLevelThree"), lineWidth: 1)
                        )
                        .font(viewModel.configuration.style.statusFont)
                }
            }
			.accessibilityElement(children: .combine)
			.accessibilityLabel(featureTitleDecriptionAccessibilityLabel)
            
            Spacer()
            
            if viewModel.feature.hasNotFinished {
                RoadmapVoteButton(viewModel: viewModel)
            }
        }
        .padding()
    }
    
    var verticalCell : some View {
        VStack(alignment: .leading, spacing: 16) {
            if viewModel.feature.hasNotFinished {
                HStack {
                    RoadmapVoteButton(viewModel: viewModel)
                    Spacer()
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
				VStack(alignment: .leading, spacing: 0) {
					HStack {
						Text(viewModel.feature.localizedFeatureTitle)
							.font(viewModel.configuration.style.titleFont)
							.foregroundColor(viewModel.configuration.style.titleColor)
						
						if !viewModel.feature.hasNotFinished {
							Spacer()
						}
					}
					
					let description = viewModel.feature.localizedFeatureDescription
					if !description.isEmpty {
						Text(description)
							.font(viewModel.configuration.style.numberFont)
							.foregroundColor(viewModel.configuration.style.descriptionColor)
					}
				}
				.accessibilityElement(children: .combine)
				.accessibilityLabel(featureTitleDecriptionAccessibilityLabel)

                if let localizedStatus = viewModel.feature.localizedFeatureStatus {
                    Text(localizedStatus)
                        .padding(6)
                        .background(viewModel.configuration.style.statusTintColor)
                        .foregroundColor(viewModel.configuration.style.statusColor)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("blackLevelThree"), lineWidth: 1)
                        )
                        .font(viewModel.configuration.style.statusFont)
                }
            }
			.accessibilityElement(children: .combine)
			.accessibilityLabel(featureTitleDecriptionAccessibilityLabel)
        }
        .padding()
    }
}

struct RoadmapFeatureView_Previews: PreviewProvider {
    static var previews: some View {
        RoadmapFeatureView(viewModel: .init(feature: .sample(), configuration: .sampleURL()))
    }
}
