//
//  MyPageMainView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct MyPageMainView: View {
    @State private var level: Int
    @State private var currentScore: Int
    @State private var badgeCount: Int
    
    private let maxScore: Int
    private let title: String
    
    init(
        level: Int,
        currentScore: Int,
        badgeCount: Int,
        maxScore: Int = 200,
        title: String = "가판대"
    ) {
        self._level = State(initialValue: level)
        self._currentScore = State(initialValue: currentScore)
        self._badgeCount = State(initialValue: badgeCount)
        self.maxScore = maxScore
        self.title = title
    }
    
    var body: some View {
        VStack (spacing: 0) {
            HeaderView(
                level: level,
                title: title,
                currentScore: currentScore,
                maxScore: maxScore,
                badgeCount: badgeCount
            )
            Spacer()
        }
    }
}

struct HeaderView: View {
    private let level: Int
    private let title: String
    private let currentScore: Int
    private let maxScore: Int
    private let badgeCount: Int
    
    init(
        level: Int,
        title: String,
        currentScore: Int,
        maxScore: Int,
        badgeCount: Int
    ) {
        self.level = level
        self.title = title
        self.currentScore = currentScore
        self.maxScore = maxScore
        self.badgeCount = badgeCount
    }
    
    var body: some View {
        ZStack() {
            VStack {
                backgroundView
                
                Spacer()
            }
            VStack {
                VStack(spacing: 22) {
                    experienceView
                    
                    BadgeSection(
                        badgeCount: badgeCount,
                        onBadgeSettingTap: {
                            print("뱃지 설정하기 클릭")
                        },
                        onBadgeCollectionTap: {
                            print("뱃지 도감 클릭")
                        }
                    )
                }
                .padding(.top, 330)
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    var backgroundView: some View {
        Color(.backgroundAccent)
            .cornerRadius(
                32,
                corners: [
                    .bottomLeft,
                    .bottomRight
                ]
            )
            .frame(height: 416)
            .onTapGesture {
                print("레벨업 상태 화면으로 change 예정")
            }
    }
    
    var experienceView: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            HStack {
                Chip(type: .level(level))
                CustomText(
                    title,
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
                        "\(Int(currentScore))/\(Int(maxScore))",
                        fontType: .label2Medium,
                        color: Color(.labelAlternative)
                    )
                }
            }
            
            ProgressView(
                value: Double(currentScore),
                total: Double(maxScore)
            )
            .progressViewStyle(LinearProgressViewStyle(tint: .black))
            .frame(height: 8)
            .background(
                Capsule()
                    .fill(Color.gray.opacity(0.3))
            )
        }
        .padding(
            .horizontal,
            67.5
        )
    }
    
}

struct BadgeSection: View {
    private let badgeCount: Int
    private let onBadgeSettingTap: () -> Void
    private let onBadgeCollectionTap: () -> Void
    
    init(
        badgeCount: Int,
        onBadgeSettingTap: @escaping () -> Void,
        onBadgeCollectionTap: @escaping () -> Void
    ) {
        self.badgeCount = badgeCount
        self.onBadgeSettingTap = onBadgeSettingTap
        self.onBadgeCollectionTap = onBadgeCollectionTap
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 73.5) {
            VStack(spacing: 6) {
                Button(action: onBadgeSettingTap) {
                    Image(.badge)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 80,
                            height: 80
                        )
                }
                CustomText(
                    "뱃지 설정하기",
                    fontType: .caption1Medium,
                    color: Color(.labelAssistive)
                )
            }
            
            VStack(spacing: 6) {
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
                        Image(.chevronRight)
                    }
                    
                    Spacer()
                }
                .frame(height: 80)
                
                CustomText(
                    "배지 도감",
                    fontType: .caption1Medium,
                    color: Color(.labelAssistive)
                )
            }
            .onTapGesture {
                onBadgeCollectionTap()
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
    MyPageMainView(level: 1, currentScore: 50, badgeCount: 4)
}
