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
    @State var announceState: NicknameTextFieldAlertCase? = .alert
    @State var state: TextFieldState = .defaultState
    
    var body: some View {
        VStack(spacing: 0) {
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
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $nickname,
                style: .nickname,
                state: state,
                alertText: announceState
            )
        )
    }
}

#Preview {
    NameInputView(nickname: .constant("서유나"))
}
