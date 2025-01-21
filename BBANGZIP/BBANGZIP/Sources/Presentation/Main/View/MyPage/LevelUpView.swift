//
//  LevelUpView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct LevelUpView: View {
    @StateObject var viewModel: MyPageMainViewModel
    @State private var selectedIndex: Int = 0

    init(viewModel: MyPageMainViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _selectedIndex = State(initialValue: viewModel.level - 1)
    }

    var body: some View {
        VStack(spacing: 0) {
            navBar
            levelTabView
            content
        }
        .navigationBarHidden(true)
    }

    private var navBar: some View {
        CustomNavBarView(
            showBackButton: true,
            title: "내 제과제빵점",
            backgroundColor: Color(.backgroundAccent)
        )
    }

    private var levelTabView: some View {
        ZStack {
            Color(.backgroundAccent)
            TabView(selection: $selectedIndex) {
                ForEach(
                    0..<viewModel.levelStateCount,
                    id: \ .self
                ) { index in
                    BbangZipView(badgeLevel: index + 1)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        .frame(height: 416)
        .cornerRadius(
            32,
            corners: [
                .bottomLeft,
                .bottomRight
            ]
        )
    }

    private var content: some View {
        VStack(spacing: 8) {
            header
            Spacer()
            levelContent
            Spacer()
        }
        .padding(.top, 24)
    }

    private var header: some View {
        HStack(spacing: 8) {
            Spacer()
            Chip(type: .level(selectedIndex + 1))
            CustomText(
                viewModel.title,
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
            Spacer()
        }
    }

    @ViewBuilder
    private var levelContent: some View {
        if selectedIndex + 1 <= viewModel.level {
            CustomText(
                viewModel.badgeStatement,
                fontType: .headline2Bold,
                color: Color(.labelNormal)
            )
            .multilineTextAlignment(.center)
        } else {
            lockedContent
        }
    }

    private var lockedContent: some View {
        ZStack {
            Image(.private)
            VStack {
                CustomText(
                    "열심히 포인트를 모아서\n멋진 빵집을 차려봐요!",
                    fontType: .body1Bold,
                    color: Color(.labelAlternative)
                )
            }
            .multilineTextAlignment(.center)
        }
        .ignoresSafeArea()
    }
}

struct BbangZipView: View {
    let badgeLevel: Int

    var body: some View {
        ZStack {
            // TODO: 여기에 빵집 레벨업 이미지 들어올 예정 아직 미정.
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
}

struct CustomNavBarView: View {
    @SwiftUI.Environment(\ .presentationMode) var presentationMode
    let showBackButton: Bool
    let title: String
    let backgroundColor: Color?

    init(
        showBackButton: Bool,
        title: String,
        backgroundColor: Color
    ) {
        self.showBackButton = showBackButton
        self.title = title
        self.backgroundColor = backgroundColor
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea(edges: .top)
            HStack {
                if showBackButton {
                    backButton
                }
                Spacer()
                CustomText(
                    title,
                    fontType: .headline1Bold,
                    color: Color(.labelNeutral)
                )
                Spacer()
                ZStack {}
                    .frame(
                        width: 24,
                        height: 24
                    )
            }
            .padding(.horizontal)
        }
        .ignoresSafeArea()
        .frame(height: 103)
    }

    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(.chevronLeftThickSmall)
                .resizable()
                .frame(
                    width: 24,
                    height: 24
                )
        }
    }
}
