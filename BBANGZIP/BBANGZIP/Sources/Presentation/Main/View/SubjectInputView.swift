//
//  SubjectInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectInputView: View {
    @State private var currentStep: Step
    @State private var subject: String
    @State private var selectedYear: Int
    @State private var selectedSemester: Semester
    @State private var announceState: NicknameTextFieldAlertCase?
    @State private var state: TextFieldState
    
    init(
        // TODO: 부모 뷰에서 공통적으로 사용할 currentStep은 삭제 필요
        currentStep: Step = .third,
        subject: String = "",
        selectedYear: Int = 2025,
        selectedSemester: Semester = Semester.first,
        announceState: NicknameTextFieldAlertCase? = nil,
        state: TextFieldState = .defaultState
    ) {
        self.currentStep = currentStep
        self.subject = subject
        self.selectedYear = selectedYear
        self.selectedSemester = selectedSemester
        self.announceState = announceState
        self.state = state
    }
    
    var body: some View {
        VStack(spacing: 0) {
//            ProgressBar(category: $currentStep)
//                .padding(
//                    .horizontal,
//                    44
//                )
//                .padding(
//                    .bottom,
//                    48
//                )
            
            VStack(spacing: 0) {
                headerDescription
                
                mainDescription
                
                subjectTextField
                
                Spacer()
                
//                nextButton
            }
            .padding(
                .horizontal,
                20
            )
        }
//        .navigationBarBackButtonHidden()
//        .toolbar {
//            ToolbarItemGroup(placement: .topBarLeading) {
//                backButton
//            }
//        }
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
                    "수강하는 과목 중\n한 가지만 먼저 입력해 볼까요?",
                    fontType: .title2Bold,
                    color: Color(.labelNormal)
                )
                Spacer()
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
                buttonImage: Image(.chevronRight)
            )
        )
        
    }
}

#Preview {
    SubjectInputView(
        subject: "경제학원론",
        selectedYear: 2025,
        selectedSemester: Semester.summer
    )
}
