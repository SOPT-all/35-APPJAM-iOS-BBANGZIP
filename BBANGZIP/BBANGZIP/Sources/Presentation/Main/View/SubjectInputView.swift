//
//  SubjectInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectInputView: View {
    @Binding var subject: String
    @Binding var selectedYear: Int
    @Binding var selectedSemester: Semester
    @State var announceState: SubjectTextFieldAlertCase? = .alert
    @State var state: TextFieldState = .defaultState
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                headerDescription
                
                mainDescription
                
                subjectTextField
                
                Spacer()
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var headerDescription: some View {
        HStack(spacing: 0) {
            CustomText(
                "\(selectedYear)년 \(selectedSemester.text)에 재학 중이시네요!",
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
            "예) 거시경제학",
            text: $subject
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $subject,
                style: .subject,
                state: state,
                alertText: announceState
            )
        )
    }
}

#Preview {
    SubjectInputView(
        subject: .constant("경제학원론"),
        selectedYear: .constant(2025),
        selectedSemester: .constant(Semester.summer)
    )
}
