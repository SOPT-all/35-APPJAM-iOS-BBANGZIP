//
//  BadgeCategoryViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class BadgeCategoryViewModel: ObservableObject {
    
    @Published var badgeList: [BadgeListModel] = []
    @Published var nickname: String = "아요짱"
    @Published var isBottomSheetShowing: Bool = false
    
    private let getBadgeListUseCase: GetBadgeListUseCase?
    
    init(getBadgeListUseCase: GetBadgeListUseCase? = nil, useMockData: Bool = false) {
        self.getBadgeListUseCase = getBadgeListUseCase
        
        if useMockData {
            loadMockData()
        }
    }
    
    @MainActor
    func fetchData() async {
        guard let getBadgeListUseCase = getBadgeListUseCase else { return }
        do {
            let result = try await getBadgeListUseCase.execute()
            badgeList = result.badgeCategoryList
            nickname = result.nickname
        } catch {
            dump(error)
        }
    }
    
    func subtitle(for category: String) -> String {
        switch category {
        case "시작이 빵이다":
            return "이번 학기 빵점 탈출 내가 해냄!"
        case "미룬이 탈출":
            return "지금 바로 시작하면 미룬이 탈출 가능!"
        case "미룬이 겨우 탈출":
            return "미룬이 탈출 막차 탑승!"
        case "인싸 사장님":
            return "빵 한 쪽도 나눠 먹는 사이!"
        default:
            return ""
        }
    }
    
    private func loadMockData() {
        nickname = "아요짱"
        badgeList = [
            BadgeListModel(
                badgeCategry: .start,
                badgeList: [
                    BadgeModel(
                        badgeCategory: "시작이 빵이다",
                        badgeName: "빵집 오픈 준비 중",
                        badgeIsLocked: false,
                        badgeImage: "star"
                    ),
                    BadgeModel(
                        badgeCategory: "시작이 빵이다",
                        badgeName: "빵 굽기 시작",
                        badgeIsLocked: true,
                        badgeImage: "lock"
                    )
                ]
            ),
            BadgeListModel(
                badgeCategry: .escape,
                badgeList: [
                    BadgeModel(
                        badgeCategory: "미룬이 탈출",
                        badgeName: "미룬이탈출1",
                        badgeIsLocked: true,
                        badgeImage: "lock"
                    )
                ]
            )
        ]
    }
}
