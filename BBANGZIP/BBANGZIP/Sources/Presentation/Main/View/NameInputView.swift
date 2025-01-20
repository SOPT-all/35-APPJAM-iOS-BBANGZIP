//
//  NameInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct NameInputView: View {
    @Binding var nickname: String
    @State var oldNickname: String = ""
    
    @FocusState private var isNicknameFocused: Bool
    @StateObject private var viewModel: OnboardingViewModel
    
    init(
        viewModel: OnboardingViewModel = OnboardingViewModel(),
        nickname: Binding<String>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._nickname = nickname
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ProgressBar(type: .withCircle(category: viewModel.currentStep))
                .padding(
                    .horizontal,
                    44
                )
                .padding(
                    .bottom,
                    78
                )
            
            VStack(spacing: 32) {
                mainDescription
                
                nicknameTextField
                
                Spacer()
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var mainDescription: some View {
        HStack {
            CustomText(
                "사장님의 이름을\n알려주세요",
                fontType: .title2Bold,
                color: Color(.labelNormal)
            )
            .padding(
                .top,
                30
            )
            
            Spacer()
        }
    }
    
    private var nicknameTextField: some View {
        TextField(
            "예) 탁구왕김제빵",
            text: $nickname
        )
        .focused($isNicknameFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $nickname,
                style: .nickname,
                state: viewModel.nicknameState,
                alertText: viewModel.nicknameAnnounceState
            )
        )
        .onChange(of: nickname) { newNickname in
            if newNickname.count > 10 {
                nickname = String(newNickname.prefix(10))
            }
            
            viewModel.verifyNickname(
                oldText: oldNickname,
                newText: newNickname,
                isNicknameFocused: isNicknameFocused
            )
            
            oldNickname = viewModel.nickname
        }
        .onChange(of: isNicknameFocused) { isNicknameFocused in
            viewModel.handleNicknameFocusChange(
                isNicknameFocused: isNicknameFocused,
                text: nickname
            )
        }
    }
}
