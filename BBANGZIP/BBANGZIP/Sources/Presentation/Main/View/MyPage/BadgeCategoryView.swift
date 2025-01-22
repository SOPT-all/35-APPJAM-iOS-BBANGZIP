//
//  BadgeCategoryView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct BadgeCategoryView: View {
    @StateObject private var viewModel: BadgeCategoryViewModel
    
    init(viewModel: BadgeCategoryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                showBackButton: true,
                showMenu: false,
                title: "배지 도감",
                backgroundColor: Color(.backgroundAccent)
            )
            .navigationBarHidden(true)
            
            ScrollView {
                HeaderView
                
                ForEach(
                    viewModel.orderedCategories,
                    id: \..self
                ) { category in
                    if let badges = viewModel.groupedBadges[category] {
                        SectionView(
                            title: category,
                            subtitle: viewModel.subtitle(for: category),
                            badges: badges
                        ) { badge in
                            print("Badge tapped: \(badge.badgeName)")
                        }
                    }
                }
            }
        }
    }
    
    private var HeaderView: some View {
        ZStack {
            HStack {
                CustomText(
                    "유나짱 사장님이\n열심히 모은 배지예요",
                    fontType: .heading2Bold,
                    color: Color(.labelNormal)
                )
                .padding(.leading, 28)
                .padding(.bottom, 48)
                
                Spacer()
                
                ZStack {}
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 121)
        .background(Color(.backgroundAccent))
        .cornerRadius(
            32,
            corners: [
                .bottomLeft,
                .bottomRight
            ]
        )
        .padding(
            .bottom,
            48
        )
    }
}

struct SectionView: View {
    let title: String
    let subtitle: String
    let badges: [Badge]
    let onBadgeTap: (Badge) -> Void
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            SectionHeaderView(
                title: title,
                subtitle: subtitle
            )
            
            LazyVGrid(
                columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: 3),
                spacing: 20
            ) {
                ForEach(badges, id: \..badgeName) { badge in
                    Button(action: {
                        onBadgeTap(badge)
                        print("Badge tapped: \(badge.badgeName)")
                        //TODO: 뱃지 상세보기로 바텀시트로 넘어가야 함.
                    }) {
                        BadgeItemView(
                            badgeImage: badge.badgeImage,
                            isLocked: badge.badgeIsLocked,
                            badgeName: badge.badgeName
                        )
                    }
                }
            }
            .padding(.horizontal, 36)
            .padding(.bottom, 64)
        }
    }
}

private struct BadgeItemView: View {
    let badgeImage: String
    let isLocked: Bool
    let badgeName: String
    
    var body: some View {
        ZStack {
            Image(systemName: badgeImage)
                .frame(
                    width: 80,
                    height: 80
                )
                .blur(radius: isLocked ? 3 : 0)
            if isLocked {
                Image(.privateWhite)
                    .scaledToFit()
            }
        }
        .frame(
            width: 80,
            height: 80
        )
    }
}

private struct SectionHeaderView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        HStack {
            VStack(
                alignment: .leading,
                spacing: 0
            ) {
                CustomText(
                    title,
                    fontType: .title3Bold,
                    color: Color(.labelNormal)
                )
                
                CustomText(
                    subtitle,
                    fontType: .label1Bold,
                    color: Color(.labelAlternative)
                )
            }
            .padding(.leading, 28)
        }
    }
}
