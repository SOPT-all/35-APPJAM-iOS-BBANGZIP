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
    @State private var isBottomSheetShowing: Bool = false
    @State private var selectedBadge: BadgeModel? = nil // 선택된 배지 정보
    
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
                        HeaderView
                        
                        ForEach(viewModel.badgeList, id: \.self) { badgeListModel in
                            let category = badgeListModel.badgeCategry
                            let list = badgeListModel.badgeList
                            
                            HStack {
                                VStack(alignment: .leading) {
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
                                }.padding(.leading, 20)
                                
                                Spacer()
                            }
                            
                            LazyVGrid(
                                columns: Array(
                                    repeating: GridItem(
                                        spacing: 32
                                    ),
                                    count: 3
                                ),
                                spacing: 32
                            ) {
                                ForEach(list, id: \.self) { badge in
                                    Button {
                                        selectedBadge = badge
                                        isBottomSheetShowing = true
                                    } label: {
                                        BadgeItemView(
                                            badgeImage: badge.badgeImage,
                                            isLocked: badge.badgeIsLocked,
                                            badgeName: badge.badgeName
                                        )
                                        .frame(width: 80, height: 80)
                                        .padding(.top, 24)
                                    }
                                }
                            }
                            .padding(.horizontal, 36)
                            .padding(.bottom, 64)
                        }
                    }
                    if let selectedBadge = selectedBadge {
                        BottomSheet(
                            isShowing: $isBottomSheetShowing,
                            height: 662
                        ) {
                            BadgeDetailView(
                                viewModel: BadgeDetailViewModel(
                                    fetchBadgeDetialUseCase: DefaultFetchDetailUseCase(repository: DefaultBadgeRepository()),
                                    badgeName: selectedBadge.badgeName
                                ),
                                isBottomSheetShowing: $isBottomSheetShowing
                            )
                        }
                    }
                }
            }
        }
    }
    
    private var HeaderView: some View {
        ZStack {
            HStack(spacing: 0) {
                Spacer()
                Image(.badgeGroup)
                    .padding(.trailing, 23)
            }
            HStack {
                CustomText(
                    "\(viewModel.nickname) 사장님이\n열심히 모은 배지예요",
                    fontType: .heading2Bold,
                    color: Color(.labelNormal)
                )
                .padding(.leading, 28)
                .padding(.bottom, 48)
                Spacer()
            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity)
        .frame(height: 127)
        .background(Color(.backgroundAccent))
        .cornerRadius(32, corners: [.bottomLeft, .bottomRight])
        .padding(.bottom, 48)
    }
    
    private struct BadgeItemView: View {
        let badgeImage: String
        let isLocked: Bool
        let badgeName: String
        
        var body: some View {
            ZStack {
                KFImage(URL(string: badgeImage))
                    .resizable()
                    .frame(width: 80, height: 80)
                    .blur(radius: isLocked ? 3 : 0)
                    .cornerRadius(24)
                
                if isLocked {
                    Image(.privateWhite)
                        .resizable()
                        .frame(width: 20, height: 26)
                }
            }
            .frame(width: 80, height: 80)
        }
    }
}

//
//#Preview {
//    let mockViewModel: BadgeCategoryViewModel = {
//        let viewModel = BadgeCategoryViewModel(useMockData: true)
//        return viewModel
//    }()
//
//    BadgeCategoryView(viewModel: mockViewModel)
//}
