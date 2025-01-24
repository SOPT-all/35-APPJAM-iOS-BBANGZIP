//
//  BadgeDetailView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

import Kingfisher

struct BadgeDetailView: View {
    @StateObject private var viewModel: BadgeDetailViewModel
    @Binding var isBottomSheetShowing: Bool
    
    init(viewModel: BadgeDetailViewModel, isBottomSheetShowing: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isBottomSheetShowing = isBottomSheetShowing
    }
    
    var body: some View {
        if viewModel.badgeDetail == nil {
            ProgressView()
                .onAppear {
                    Task {
                        try await viewModel.fetchData()
                    }
                }
        } else {
            VStack() {
                badgeContentView
                
                achievementConditionView
                
                rewardView
                
                closeButton
            }
            .frame(width: 375, height: 662)
        }
    }
    
    var badgeContentView: some View {
        ZStack{
            
            if let badgeDetail = viewModel.badgeDetail {
                ZStack{
                    VStack {
                        VStack(spacing: 0) {
                            KFImage(URL(string: badgeDetail.badgeImage))
                                .resizable()
                                .cornerRadius(48)
                                .frame(
                                    width: 160,
                                    height: 160
                                )
                                .padding(
                                    .bottom,
                                    24
                                )
                            
                            BalloonWithout(
                                text: badgeDetail.badgeName,
                                balloonMode: .top
                            ).padding(.bottom, 32)
                                .padding(.horizontal)
                            
                            hashTagTextView
                        }
                        .blur(radius: badgeDetail.badgeIsLocked ? 10 : 0)
                    }
                }
                
                if badgeDetail.badgeIsLocked {
                    Image(.locker)
                }
            }
        }
    }
    
    var hashTagTextView: some View {
        VStack(alignment: .center, spacing: 4) {
            if let badgeDetail = viewModel.badgeDetail {
                if badgeDetail.hashTags.count == 2 {
                    HStack {
                        CustomText(
                            badgeDetail.hashTags[0],
                            fontType: .body2Bold,
                            color: Color(.labelAssistive)
                        )
                    }
                    
                    HStack {
                        CustomText(
                            badgeDetail.hashTags[1],
                            fontType: .body2Bold,
                            color: Color(.labelAssistive)
                        )
                    }
                } else if badgeDetail.hashTags.count == 3 {
                    HStack {
                        CustomText(
                            badgeDetail.hashTags[0],
                            fontType: .body2Bold,
                            color: Color(.labelAssistive)
                        )
                    }
                    HStack(spacing: 8) {
                        CustomText(
                            badgeDetail.hashTags[1],
                            fontType: .body2Bold,
                            color: Color(.labelAssistive)
                        )
                        CustomText(
                            badgeDetail.hashTags[2],
                            fontType: .body2Bold,
                            color: Color(.labelAssistive)
                        )
                    }
                }
            }
        }.padding(.horizontal)
        
    }
    
    var achievementConditionView: some View {
        HStack {
            if let badgeDetail = viewModel.badgeDetail {
                VStack (alignment: .leading, spacing: 0) {
                    CustomText(
                        "달성 조건",
                        fontType: .body1Bold,
                        color: Color(.labelNormal)
                    )
                    
                    CustomText(
                        badgeDetail.achievementCondition,
                        fontType: .label1Bold,
                        color: Color(.labelAlternative)
                    )
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
    }
    
    var rewardView: some View {
        HStack {
            if let badgeDetail = viewModel.badgeDetail {
                CustomText(
                    "리워드",
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
                
                Spacer()
                
                Chip(type: .points(badgeDetail.reward))
            }
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
            isBottomSheetShowing = false
        }
        .buttonStyle(SolidButton())
        .padding(.horizontal,20)
        .padding(.top, 20)
    }
}
