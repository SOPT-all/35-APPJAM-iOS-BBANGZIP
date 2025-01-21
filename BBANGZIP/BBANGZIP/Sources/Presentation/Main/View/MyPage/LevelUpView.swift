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
    }
    
    var body: some View {
        VStack (spacing: 0) {
            ZStack {
                Color(.backgroundAccent)
                
                TabView(selection: $selectedIndex) {
                    ForEach(0..<viewModel.levelStateCount, id: \.self) { index in
                        BbangZipView(badgeLevel: index + 1)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
            }
            .frame(height: 519)
            .cornerRadius(32, corners: [.bottomLeft, .bottomRight])

            
            VStack (spacing: 8) {
                HStack(spacing:8) {
                    
                    Spacer()
                    
                    Chip(type: .level(viewModel.level))
                    
                    CustomText(
                        viewModel.title, fontType: .body1Bold, color: Color(.labelNormal))
                    
                    Spacer()
                }
                
                Spacer()
                
                if selectedIndex + 1 <= viewModel.level {
                    CustomText(viewModel.badgeStatement, fontType: .headline2Bold, color: Color(.labelNormal))
                        .multilineTextAlignment(.center)
                }
                else {
                    CustomText("열심히 포인트를 모아서\n 멋진 빵집을 차려봐요!", fontType: .body1Bold, color: Color(.labelAlternative))
                }
                
                Spacer()
            }
            .padding(.top, 24)
        }
        .ignoresSafeArea()
        
    }
}






struct BbangZipView: View {
    let badgeLevel: Int
    
    var body: some View {
        ZStack {
            //TODO: 여기에 빵지비 레벨업 이미지 들어올 예정 아직 미정.
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}

