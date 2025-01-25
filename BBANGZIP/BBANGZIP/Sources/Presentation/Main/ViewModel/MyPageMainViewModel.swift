//
//  MyPageMainViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class MyPageMainViewModel: ObservableObject {
    @Published var level: Int = 0
    @Published var currentScore: Int = 0
    @Published var badgeCount: Int = 0
    @Published var maxScore: Int = 0
    @Published var title: String = ""
    @Published var badgeStatement: String = ""
    @Published var profileThumbnail: String = ""
    var levelStateCount: Int = 0 // ??
    @Published var allLevel: [LevelDetail] = []
    //TODO: 서버와의 논의 후 image string 여부 결정 예정
    
    let fetchMyPageUseCase: FetchMyPageUseCase
    
    init(
        fetchMyPageUseCase: FetchMyPageUseCase
    ) {
        self.fetchMyPageUseCase = fetchMyPageUseCase
    }
    
    var progress: Double {
        Double(currentScore) / Double(maxScore)
    }
    
    @MainActor
    func fetchData() async {
        do {
            let result = try await fetchMyPageUseCase.execute()
            level = result.level
            currentScore = result.reward
            badgeCount = result.badgeCounts
            maxScore = result.maxReward
            allLevel = result.levelDetails
            if result.levelDetails.isEmpty {
                title = "허름한 돗자리"
                badgeStatement = "빵집을 시작한지 얼마 안된 사장님의 첫 빵집이에요."
            } else {
                title = result.levelDetails[level - 1].levelName
                profileThumbnail = result.levelDetails[level - 1].levelImage
                badgeStatement = result.levelDetails[level - 1].levelDescription
            }
            
        } catch {
            dump(error)
        }
    }
}
