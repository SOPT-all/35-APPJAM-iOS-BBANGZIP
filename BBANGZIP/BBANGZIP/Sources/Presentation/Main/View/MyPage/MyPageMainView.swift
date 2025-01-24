//  Created by 송여경 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
// MyPageMainView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.

import SwiftUI

struct MyPageMainView: View {
    @StateObject private var viewModel: MyPageMainViewModel
    @State private var showLevelUpView = false
    @Binding var isCustomTabBarHidden: Bool
    @State private var showLogoutSheet = false
    @State private var showDeleteAccountSheet = false
    
    init(
        viewModel: MyPageMainViewModel,
        isCustomTabBarHidden: Binding<Bool>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isCustomTabBarHidden = isCustomTabBarHidden
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    HeaderView(
                        viewModel: viewModel,
                        badgeCategoryViewModel: BadgeCategoryViewModel(getBadgeListUseCase: DefaultGetBadgeListUseCase(repository: DefaultBadgeRepository()))
                    )
                    
                    GridView(
                        isCustomTabBarHidden: $isCustomTabBarHidden,
                        onLogoutTap: { showLogoutSheet = true },
                        onDeleteAccountTap: { showDeleteAccountSheet = true }
                    )
                    .padding(.top, 75)
                }
                
                Spacer()
            }
            .scrollIndicators(.hidden)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
            
            if showLogoutSheet || showDeleteAccountSheet {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showLogoutSheet = false
                        showDeleteAccountSheet = false
                    }
            }
            
            if showLogoutSheet {
                BottomSheet(
                    isShowing: $showLogoutSheet,
                    height: 265
                ) {
                    MyPageBottomSheet(
                        title: "로그아웃 하시겠어요?",
                        primaryButtonTitle: "로그아웃 하기",
                        primaryButtonAction: {
                            print("로그아웃 실행")
                            // TODO: 로그아웃 기능 추가
                            showLogoutSheet = false
                        },
                        isBottonSheetShowing: $showLogoutSheet
                    )
                }
                
            }
            
            if showDeleteAccountSheet {
                BottomSheet(
                    isShowing: $showDeleteAccountSheet,
                    height: 265
                ) {
                    MyPageBottomSheet(
                        title: "정말 탈퇴하시겠어요?",
                        primaryButtonTitle: "탈퇴하기",
                        primaryButtonAction: {
                            print("탈퇴 실행")
                            // TODO: 계정 탈퇴 기능 추가
                            showDeleteAccountSheet = false
                        },
                        isBottonSheetShowing: $showDeleteAccountSheet
                    )
                }
                .onAppear {
                    isCustomTabBarHidden = true
                }
                .onDisappear {
                    isCustomTabBarHidden = false
                }
            }
        }
    }
}

struct GridView: View {
    let items = [
        "프로필 설정",
        "공지사항",
        "개인정보 처리방침",
        "서비스 이용약관",
        "로그아웃",
        "계정 탈퇴"
    ]
    
    @State private var selectedItem: String? = nil
    @Binding var isCustomTabBarHidden: Bool
    var onLogoutTap: () -> Void
    var onDeleteAccountTap: () -> Void
    
    init(
        isCustomTabBarHidden: Binding<Bool>,
        onLogoutTap: @escaping () -> Void,
        onDeleteAccountTap: @escaping () -> Void
    ) {
        _isCustomTabBarHidden = isCustomTabBarHidden
        self.onLogoutTap = onLogoutTap
        self.onDeleteAccountTap = onDeleteAccountTap
    }
    
    var body: some View {
        LazyVStack(spacing: 0) {
            ForEach(items.indices, id: \ .self) { index in
                Button(action: {
                    handleItemTap(index: index)
                }) {
                    HStack {
                        CustomText(
                            items[index],
                            fontType: .body1Bold,
                            color: Color(.labelNormal)
                        )
                        .padding(.leading, 8)
                        Spacer()
                        Image(.rightIcon)
                            .frame(width: 20, height: 20)
                    }
                    .frame(width: 335, height: 56)
                    .background(Color.clear)
                }
                .buttonStyle(PlainButtonStyle())
                
                if index == 0 || index == 3 {
                    Divider()
                        .background(Color(.lineNormal))
                        .padding(.vertical, 16)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 80)
    }
    
    private func handleItemTap(index: Int) {
        switch items[index] {
        case "로그아웃":
            onLogoutTap()
        case "계정 탈퇴":
            onDeleteAccountTap()
        default:
            print("\(items[index]) 선택됨")
            // TODO: 다른 항목 처리 추가
        }
        
    }
}

struct BadgeSection: View {
    let badgeCount: Int
    let onBadgeSettingTap: () -> Void
    let onBadgeCollectionTap: () -> Void
    @ObservedObject var badgeCategoryViewModel: BadgeCategoryViewModel
    @State private var navigateToBadgeCategory = false
    
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
                    fontType: .caption2Medium,
                    color: Color(.labelAssistive)
                )
            }
            
            VStack(spacing: 6) {
                Button(action: {
                    navigateToBadgeCategory = true
                    onBadgeCollectionTap()
                }) {
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
                                fontType: .caption2Medium,
                                color: Color(.label)
                            )
                            
                            Image(.chevronRightThickSmall)
                                .foregroundColor(Color(.labelAssistive))
                                .frame(width: 24, height: 24)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 80)
                }
                
                CustomText(
                    "배지 도감",
                    fontType: .caption2Medium,
                    color: Color(.labelAssistive)
                )
            }
        }
        .padding(.vertical, 24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 40)
                .fill(Color(.staticWhite))
                .shadow(
                    color: .gray.opacity(0.3),
                    radius: 4,
                    x: 0,
                    y: 2
                )
        )
        .padding(.horizontal, 20)
        .navigationDestination(isPresented: $navigateToBadgeCategory) {
            BadgeCategoryView(viewModel: badgeCategoryViewModel)
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
                            // TODO: 화면 전환 필요
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
