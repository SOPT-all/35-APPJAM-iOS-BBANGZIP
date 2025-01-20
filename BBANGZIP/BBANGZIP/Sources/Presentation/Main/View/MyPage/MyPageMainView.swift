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
    
    init(level: Int, currentScore: Int, badgeCount: Int, maxScore: Int = 200, title: String = "가판대") {
        self._level = State(initialValue: level)
        self._currentScore = State(initialValue: currentScore)
        self._badgeCount = State(initialValue: badgeCount)
        self.maxScore = maxScore
        self.title = title
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(
                level: level,
                title: title,
                currentScore: currentScore,
                maxScore: maxScore
            )
            
            BadgeSection(
                badgeCount: badgeCount,
                onBadgeSettingTap: {
                    print("뱃지 설정하기 클릭")
                },
                onBadgeCollectionTap: {
                    print("배지 도감 클릭")
                }
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
    
    init(level: Int, title: String, currentScore: Int, maxScore: Int) {
        self.level = level
        self.title = title
        self.currentScore = currentScore
        self.maxScore = maxScore
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
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
            
            VStack(alignment: .leading, spacing: 8) {
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
                
                ProgressView(value: Double(currentScore), total: Double(maxScore))
                    .progressViewStyle(LinearProgressViewStyle(tint: .black))
                    .frame(height: 8)
                    .background(
                        Capsule()
                            .fill(Color.gray.opacity(0.3))
                    )
            }
            .padding()
            .padding([.leading, .trailing], 67.5)
            .padding(.bottom, 22)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BadgeSection: View {
    let badgeCount: Int
    let onBadgeSettingTap: () -> Void
    let onBadgeCollectionTap: () -> Void
    
    init(badgeCount: Int, onBadgeSettingTap: @escaping () -> Void, onBadgeCollectionTap: @escaping () -> Void) {
        self.badgeCount = badgeCount
        self.onBadgeSettingTap = onBadgeSettingTap
        self.onBadgeCollectionTap = onBadgeCollectionTap
    }
    
    var body: some View {
        HStack(spacing: 74.25) {
            VStack {
                Button(action: onBadgeSettingTap) {
                    Image(.badge)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                }
                CustomText("뱃지 설정하기", fontType: .caption1Medium, color: Color(.labelAssistive))
            }
            
            VStack(spacing: 4) {
                HStack(spacing: 2) {
                    CustomText(
                        "\(badgeCount)",
                        fontType: .title2Bold,
                        color: Color(.labelNormal)
                    )
                    CustomText("개", fontType: .body1Medium, color: Color(.labelNormal))
                    Image(.chevronRight)
                }
                .padding(.bottom)
                
                CustomText("배지 도감", fontType: .caption1Medium, color: Color(.labelAssistive))
            }
            .padding(.bottom, -24)
            .onTapGesture {
                onBadgeCollectionTap()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
        )
        .padding([.leading, .trailing], 24)
        .padding(.top, -16)
    }
}

#Preview {
    MyPageMainView(level: 1, currentScore: 50, badgeCount: 8)
}
