//
//  BadgeDetailViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class BadgeDetailViewModel: ObservableObject {
    @Published var badgeDetail: BadgeDetail?
    
    private let targetBadgeName: String
    private let fetchBadgeDetialUseCase: FetchBadgeDetailUseCase
    
    init(
        fetchBadgeDetialUseCase: FetchBadgeDetailUseCase,
        badgeName: String
    ) {
        self.fetchBadgeDetialUseCase = fetchBadgeDetialUseCase
        self.targetBadgeName = badgeName
    }
    
    @MainActor
    func fetchData() async throws {
        badgeDetail = try await fetchBadgeDetialUseCase.execute(badgeName: targetBadgeName)
    }
}
