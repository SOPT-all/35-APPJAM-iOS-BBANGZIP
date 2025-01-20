//
//  NameInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct NameInputView: View {
    @StateObject private var viewModel: NameInputViewModel
    
    init(viewModel: NameInputViewModel = NameInputViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                backButton
            }
        }
        
    }
    
    private var backButton: some View {
        Button(action: {
            // TODO: 뒤로가기 버튼 누르면 상태 변경하도록
        }) {
            Image(.chevronLeftThickSmall)
                .renderingMode(.template)
                .foregroundStyle(Color(.labelAlternative))
            Spacer()
        }
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
        NavigationLink("다음으로") {
            // TODO: 화면 전환해야 할 다음 뷰
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronRight)
            )
        )
    }
}

#Preview {
    NameInputView()
}
