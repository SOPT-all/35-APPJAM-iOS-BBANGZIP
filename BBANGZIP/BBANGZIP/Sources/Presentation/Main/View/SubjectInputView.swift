//
//  SubjectInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectInputView: View {
    @State private var currentStep: Step = .Third
    @State private var subject: String = ""
    @State private var selectedYear: Int = 2025
    @State private var selectedSemester: String = "1학기"
    @State private var announceState: NicknameTextFieldAlertCase? = nil
    @State private var state: TextFieldState = .defaultState
    
    var body: some View {
        VStack(spacing: 0) {
            backButton
            
            ProgressBar(category: $currentStep)
                .padding(
                    .horizontal,
                    44
                )
                .padding(
                    .bottom,
                    48
                )
            
            VStack(spacing: 0) {
                headerDescription
                
                mainDescription
                
                subjectTextField
                
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
        HStack(spacing: 0) {
            Image(.chevronLeftThickSmall)
                .renderingMode(.template)
                .foregroundStyle(Color(.labelAlternative))
            Spacer()
        }
        .padding(16)
    }
    
    private var headerDescription: some View {
        HStack(spacing: 0) {
            CustomText(
                "\(selectedYear)년 \(selectedSemester)에 재학 중이시네요!",
                fontType: .body2Bold,
                color: Color(.labelAlternative)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            8
        )
    }
    
    private var mainDescription: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                CustomText(
                    "수강하는 과목 중",
                    fontType: .title2Bold,
                    color: Color(.labelNormal)
                )
                Spacer()
            }
            .padding(
                .bottom,
                5
            )
            
            HStack(spacing: 0) {
                CustomText(
                    "한 가지만 먼저 입력해 볼까요?",
                    fontType: .title2Bold,
                    color: Color(.labelNormal)
                )
            }
            .padding(
                .bottom,
                33
            )
        }
    }
    
    private var subjectTextField: some View {
        TextField(
            "예) 유나대장",
            text: $subject
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $subject,
                style: .nickname,
                state: state,
                alertText: announceState
            )
        )
    }
    
    private var nextButton: some View {
        NavigationLink("다음으로") {
            // TODO: 다음 버튼 입력 시 화면 전환 필요
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronLeftThickSmall)
            )
        )
        
    }
}

#Preview {
    SubjectInputView()
}
