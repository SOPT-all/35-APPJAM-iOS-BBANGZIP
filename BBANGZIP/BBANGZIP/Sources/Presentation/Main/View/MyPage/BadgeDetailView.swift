//
//  BadgeDetailView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct BadgeDetailView: View {
    @StateObject private var viewModel: BadgeDetailViewModel
    
    init(viewModel: BadgeDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack() {
            badgeContentView
            
            achievementConditionView
            
            rewardView
            
            closeButton
        }
        .frame(width: 375, height: 662)
    }
    
    var badgeContentView: some View {
        VStack {
            VStack(spacing: 0) {
                Image(systemName: viewModel.badgeImage)
                    .resizable()
                    .frame(
                        width: 160,
                        height: 160
                    )
                    .padding(
                        .bottom,
                        24
                    )
                
                BalloonWithout(
                    text: viewModel.badgeName,
                    balloonMode: .top
                ).padding(.bottom, 32)
                    .padding(.horizontal)
                
                hashTagTextView
            }
        }
        
    }
    
    var hashTagTextView: some View {
        VStack(alignment: .center, spacing: 4) {
            if viewModel.hashTags.count == 2 {
                HStack {
                    CustomText(
                        viewModel.hashTags[0],
                        fontType: .body2Bold,
                        color: Color(.labelAssistive)
                    )
                }
                HStack {
                    CustomText(
                        viewModel.hashTags[1],
                        fontType: .body2Bold,
                        color: Color(.labelAssistive)
                    )
                }
            } else if viewModel.hashTags.count == 3 {
                HStack {
                    CustomText(
                        viewModel.hashTags[0],
                        fontType: .body2Bold,
                        color: Color(.labelAssistive)
                    )
                }
                HStack(spacing: 8) {
                    CustomText(
                        viewModel.hashTags[1],
                        fontType: .body2Bold,
                        color: Color(.labelAssistive)
                    )
                    CustomText(
                        viewModel.hashTags[2],
                        fontType: .body2Bold,
                        color: Color(.labelAssistive)
                    )
                }
            }
        }.padding(.horizontal)
    }
    
    var achievementConditionView: some View {
        HStack {
            VStack (alignment: .leading, spacing: 0) {
                CustomText("달성 조건",fontType: .body1Bold, color: Color(.labelNormal))
                
                CustomText(viewModel.achievementCondition, fontType: .label1Bold, color: Color(.labelAlternative))
            }.padding(
                .top,
                32
            )
            .padding(
                .horizontal,
                40
            )
            
            Spacer()
        }
    }
    
    var rewardView: some View {
        HStack {
            CustomText(
                "리워드",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
            
            Chip(type: .points(viewModel.reward))
        }.padding(
            .top,
            16
        )
        .padding(
            .horizontal,
            40
        )
        
    }
    var closeButton: some View {
        Button("닫기") {
            
        }
        .buttonStyle(SolidButton())
        .padding(.horizontal,20)
        .padding(.top, 20)
    }
}

#Preview {
    BadgeDetailView(viewModel: BadgeDetailViewModel(
        badgeName: "빵집 오픈 준비 중",
        badgeImage: "bread.fill",
        hashTags: ["#일일 빵집 오픈 알바생", "#가만히 있으면 빵도 못 간다", "#사장님 여기 빵 안나와요?"],
        achievementCondition: "최초로 '공부 할 내용'을 추가한 경우",
        reward: 50,
        badgeIsLocked: false )
    )
}
