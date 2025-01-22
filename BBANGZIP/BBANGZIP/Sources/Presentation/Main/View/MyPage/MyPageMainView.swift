// MyPageMainView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct MyPageMainView: View {
    @StateObject private var viewModel: MyPageMainViewModel
    @StateObject private var badgeCategoryViewModel: BadgeCategoryViewModel
    @State private var showLevelUpView = false
    
    init(viewModel: MyPageMainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _badgeCategoryViewModel = StateObject(
            wrappedValue: BadgeCategoryViewModel(
                badges: mockBadges,
                userID: "유나짱"
            )
        )
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HeaderView(
                    viewModel: viewModel,
                    badgeCategoryViewModel: badgeCategoryViewModel
                )
            }
            
            Spacer()
        }
    }
}

struct HeaderView: View {
    @ObservedObject var viewModel: MyPageMainViewModel
    @ObservedObject var badgeCategoryViewModel: BadgeCategoryViewModel
    
    var body: some View {
        ZStack {
            VStack {
                backgroundView
                
                Spacer()
            }
            
            VStack {
                VStack(spacing: 22) {
                    experienceView
                    
                    BadgeSection(
                        badgeCount: viewModel.badgeCount,
                        onBadgeSettingTap: {
                            print("뱃지 설정하기 클릭")
                            //TODO: 화면 전환 필요
                        },
                        onBadgeCollectionTap: {
                            print("뱃지 도감 클릭")
                        },
                        badgeCategoryViewModel: badgeCategoryViewModel
                    )
                }
                .padding(.top, 330)
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    var backgroundView: some View {
        NavigationLink {
            LevelUpView(viewModel: viewModel)
        } label: {
            Color(.backgroundAccent)
                .cornerRadius(
                    32,
                    corners: [
                        .bottomLeft,
                        .bottomRight
                    ]
                )
                .frame(height: 416)
        }
    }
    
    
    var experienceView: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            HStack {
                Chip(type: .level(viewModel.level))
                
                CustomText(
                    viewModel.title,
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
                
                Spacer()
                
                HStack(spacing: 0) {
                    Image(.trophyGray)
                        .scaledToFit()
                        .frame(
                            width: 24,
                            height: 24
                        )
                    
                    CustomText(
                        "\(viewModel.currentScore)/\(viewModel.maxScore)",
                        fontType: .label2Medium,
                        color: Color(.labelAlternative)
                    )
                }
            }
            
            ProgressBar(type: .basic(progress: viewModel.progress))
        }
        .padding(.horizontal, 40)
    }
}

struct BadgeSection: View {
    private let badgeCount: Int
    private let onBadgeSettingTap: () -> Void
    private let onBadgeCollectionTap: () -> Void
    private let badgeCategoryViewModel: BadgeCategoryViewModel
    
    init(
        badgeCount: Int,
        onBadgeSettingTap: @escaping () -> Void,
        onBadgeCollectionTap: @escaping () -> Void,
        badgeCategoryViewModel: BadgeCategoryViewModel
    ) {
        self.badgeCount = badgeCount
        self.onBadgeSettingTap = onBadgeSettingTap
        self.onBadgeCollectionTap = onBadgeCollectionTap
        self.badgeCategoryViewModel = badgeCategoryViewModel
    }
    
    var body: some View {
        HStack(
            alignment: .bottom,
            spacing: 73.5
        ) {
            VStack(spacing: 6) {
                Button(action: onBadgeSettingTap) {
                    Image(.badge)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                
                CustomText(
                    "뱃지 설정하기",
                    fontType: .caption1Medium,
                    color: Color(.labelAssistive)
                )
            }
            
            VStack(spacing: 6) {
                NavigationLink(destination: BadgeCategoryView(viewModel: badgeCategoryViewModel)) {
                    VStack {
                        Spacer()
                        
                        HStack(spacing: 2) {
                            CustomText(
                                "\(badgeCount)",
                                fontType: .title2Bold,
                                color: Color(.labelNormal)
                            )
                            
                            CustomText(
                                "개",
                                fontType: .body1Medium,
                                color: Color(.labelNormal)
                            )
                            
                            Image(.chevronRightThickSmall)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 80)
                }
                
                CustomText(
                    "배지 도감",
                    fontType: .caption1Medium,
                    color: Color(.labelAssistive)
                )
            }
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color(.backgroundNormal))
                .shadow(
                    color: .gray.opacity(0.3),
                    radius: 4,
                    x: 0,
                    y: 2
                )
        )
        .padding(.horizontal, 20)
    }
}

#Preview {
    MyPageMainView(
        viewModel: MyPageMainViewModel(
            level: 1,
            currentScore: 40,
            badgeCount: 8,
            maxScore: 200,
            title: "가판대",
            badgeStatement: "빵집을 시작한지 얼마 안된 \n 사장님의 첫 빵집이에요"
        )
    )
}
