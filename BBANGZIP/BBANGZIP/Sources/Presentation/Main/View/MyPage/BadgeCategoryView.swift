//
//  BadgeCategoryView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

import Kingfisher

struct BadgeCategoryView: View {
    @StateObject private var viewModel: BadgeCategoryViewModel
    
    init(viewModel: BadgeCategoryViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        if viewModel.badgeList.isEmpty {
            ProgressView()
                .onAppear {
                    Task {
                        try await viewModel.fetchData()
                    }
                }
        } else {
            VStack(spacing: 0) {
                CustomNavigationBar(
                    showBackButton: true,
                    showMenu: false,
                    title: "배지 도감",
                    backgroundColor: Color(.backgroundAccent)
                )
                .navigationBarHidden(true)
                
                ZStack {
                    ScrollView {
//                        HeaderView
                        
                        ForEach(viewModel.badgeList, id: \.self) { badgeListModel in
                            
                            let category = badgeListModel.badgeCategry
                            let list =
                            
                            VStack {
                                CustomText(
                                    category.rawValue,
                                    fontType: .title3Bold,
                                    color: Color(.labelNormal)
                                )
                                
                                CustomText(
                                    category.subtitle,
                                    fontType: .label1Bold,
                                    color: Color(.labelAlternative)
                                )
                            }
                            
                            LazyVGrid(
                                columns: Array(
                                    repeating: GridItem(
                                        .flexible(),
                                        spacing: 30
                                    ),
                                    count: 3
                                ),
                                spacing: 20
                            ) {
                                ForEach(badgeListModel.badgeList, id: \.self) { badge in
                                    Button {
                                        print("\(badge.badgeName) ㅎㅎ")
                                    } label: {
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
            }
        }
    }
}
//                            if let badges = viewModel.badgeList?.badgeCategory[category] {
//                                SectionView(
//                                    title: category,
//                                    subtitle: viewModel.subtitle(for: category),
//                                    badges: badges
//                                ) { badge in
//                                    viewModel.selectedBadge = badge
//                                    viewModel.isBottomSheetShowing = true
//                                }
//                            }
//                        }
//                    }
//                    .scrollIndicators(.hidden)
//
//                    if let badgeName = viewModel.selectedBadge?.badgeName {
//                        BottomSheet(
//                            isShowing: $viewModel.isBottomSheetShowing,
//                            height: 659
//                        ) {
//                            BadgeDetailView(
//                                viewModel: BadgeDetailViewModel(
//                                    fetchBadgeDetialUseCase: DefaultFetchDetailUseCase(repository: DefaultBadgeRepository()),
//                                    badgeName: badgeName
//                                ),
//                                isBottomSheetShowing: $viewModel.isBottomSheetShowing
//                            )
//                        }
//                    }
//                }
//            }
//        }
//    }
//
//    private var HeaderView: some View {
//        ZStack {
//            HStack {
//                CustomText(
//                    "\(viewModel.nickname) 사장님이\n열심히 모은 배지예요",
//                    fontType: .heading2Bold,
//                    color: Color(.labelNormal)
//                )
//                .padding(.leading, 28)
//                .padding(.bottom, 48)
//
//                Spacer()
//            }
//        }
//        .frame(maxWidth: .infinity)
//        .frame(height: 121)
//        .background(Color(.backgroundAccent))
//        .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
//        .padding(.bottom, 48)
//    }
//}
//
//struct SectionView: View {
//    let title: String
//    let subtitle: String
////    let badges: [Badge]
////    let onBadgeTap: (Badge) -> Void
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            SectionHeaderView(title: title, subtitle: subtitle)
//
//            LazyVGrid(
//                columns: Array(repeating: GridItem(.flexible(), spacing: 30), count: 3),
//                spacing: 20
//            ) {
//                ForEach(badges, id: \ .badgeName) { badge in
//                    Button(action: {
//                        onBadgeTap(badge)
//                        print("Badge tapped: \(badge.badgeName)")
//                    }) {
//                        BadgeItemView(
//                            badgeImage: badge.badgeImage,
//                            isLocked: badge.badgeIsLocked,
//                            badgeName: badge.badgeName
//                        )
//                    }
//                }
//            }
//            .padding(.horizontal, 36)
//            .padding(.bottom, 64)
//        }
//    }
//}
//
private struct BadgeItemView: View {
    let badgeImage: String
    let isLocked: Bool
    let badgeName: String

    var body: some View {
        ZStack {
            Image(systemName: badgeImage)
                .frame(width: 80, height: 80)
                .blur(radius: isLocked ? 3 : 0)
            if isLocked {
                Image(.privateWhite)
                    .scaledToFit()
            }
        }
        .frame(width: 80, height: 80)
    }
}
//
//private struct SectionHeaderView: View {
//    var title: String
//    var subtitle: String
//
//    var body: some View {
//        HStack {
//            VStack(alignment: .leading, spacing: 0) {
//                CustomText(title, fontType: .title3Bold, color: Color(.labelNormal))
//                CustomText(subtitle, fontType: .label1Bold, color: Color(.labelAlternative))
//            }
//            .padding(.leading, 28)
//        }
//    }
//}
