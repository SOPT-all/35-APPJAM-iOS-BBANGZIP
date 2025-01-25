//
//  LevelUpView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI
import Kingfisher

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
        CustomNavigationBar(
            showBackButton: true,
            showMenu: false,
            title: "내 제과제빵점",
            backgroundColor: Color(.backgroundAccent)
        )
    }

    private var levelTabView: some View {
        ZStack {
            Color(.backgroundAccent)
            
            TabView(selection: $selectedIndex) {
                ForEach(viewModel.allLevel, id: \.self) { level in
                    KFImage(URL(string: level.levelImage))
                        .resizable()
                        .frame(
                            width: 300,
                            height: 300
                        )
                        .tag(level.level - 1)
                    
                }
                
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        
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
                viewModel.allLevel[selectedIndex].levelName,
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
                viewModel.allLevel[selectedIndex].levelDescription,
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
