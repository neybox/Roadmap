//
//  RoadmapFeatureViewModel.swift
//  Roadmap
//
//  Created by Antoine van der Lee on 19/02/2023.
//

import Foundation
import SwiftUI

final class RoadmapFeatureViewModel: ObservableObject {
    let feature: RoadmapFeature
    let configuration: RoadmapConfiguration
    let canVote: Bool
	
	@Published var hasVoted: Bool
    @Published var voteCount = 0

    init(feature: RoadmapFeature, configuration: RoadmapConfiguration) {
        self.feature = feature
        self.configuration = configuration
        self.canVote = configuration.allowVotes
		self.hasVoted = configuration.voter.hasVoted(for: feature)
    }

    @MainActor
    func getCurrentVotes() async {
        voteCount = await configuration.voter.fetch(for: feature)
    }

    @MainActor
    func vote() async {
        let newCount = await configuration.voter.vote(for: feature)
		if !Reachability.isConnectedToNetwork() {
			return
		}
        voteCount = newCount ?? (voteCount + 1)
        hasVoted = true
    }

    @MainActor
    func unvote() async {
        let newCount = await configuration.voter.unvote(for: feature)
		if !Reachability.isConnectedToNetwork() {
			return
		}
        voteCount = newCount ?? (voteCount - 1)
        hasVoted = false
    }
}
