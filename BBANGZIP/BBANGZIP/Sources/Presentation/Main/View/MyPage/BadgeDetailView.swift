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
            
            
        }
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
                
                Balloon(
                    text: viewModel.badgeName,
                    balloonMode: .top
                ).padding(.bottom, 32)
                
                hashTagTextView
                
            }
        }
        
    }
    
    var hashTagTextView: some View {
        VStack (spacing: 0) {
            CustomText(
                viewModel.hashTags.joined(separator: "\n"),  fontType: .body2Bold,
                color: Color(.labelAssistive)
            )
        }.padding(.horizontal)
    }
    
    var achievementConditionView: some View {
        VStack (spacing: 0) {
            CustomText("달성 조건",fontType: .body1Bold, color: Color(.labelNormal))
            
            CustomText(viewModel.achievementCondition, fontType: .label1Bold, color: Color(.labelAlternative))
        }.padding(
            .top,
            32
        )
        .padding(.horizontal, 40)
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
}
