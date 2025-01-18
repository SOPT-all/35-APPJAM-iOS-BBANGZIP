//
//  NameInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct NameInputView: View {
    @StateObject private var viewModel = NameInputViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            backButton
            
            ProgressBar(category: $viewModel.currentStep)
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
                
                nextButton
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var backButton: some View {
        HStack {
            Image(.chevronLeftThickSmall)
                .renderingMode(.template)
                .foregroundStyle(Color(.labelAlternative))
            Spacer()
        }
        .padding(16)
    }
    
    private var mainDescription: some View {
        HStack {
            CustomText(
                "사장님의 이름을\n알려주세요",
                fontType: .title2Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
    }
    
    private var nicknameTextField: some View {
        TextField(
            "예) 유나대장",
            text: $viewModel.nickname
        )
            .textFieldStyle(
                CustomTextFieldStyle(
                    text: $viewModel.nickname,
                    style: .nickname,
                    state: viewModel.state,
                    alertText: viewModel.announceState
                )
            )
    }
    
    private var nextButton: some View {
        Button("다음으로") {
            viewModel.handleNextButtonTapped()
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronLeftThickSmall)
            )
        )

    }
}

#Preview {
    NameInputView()
}
