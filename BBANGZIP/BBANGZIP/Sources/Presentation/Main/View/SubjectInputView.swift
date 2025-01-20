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
    @State var oldSubject: String = ""
    @Binding var selectedYear: Int
    @Binding var selectedSemester: Semester
    @FocusState private var isSubjectFocused: Bool
    @StateObject private var viewModel: OnboardingViewModel
    
    init(
        viewModel: OnboardingViewModel = OnboardingViewModel(),
        subject: Binding<String>,
        selectedYear: Binding<Int>,
        selectedSemester: Binding<Semester>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self._subject = subject
        self._selectedYear = selectedYear
        self._selectedSemester = selectedSemester
    }
    
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
                "\(selectedYear)년 \(selectedSemester.rawValue)에 재학 중이시네요!",
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
        .focused($isSubjectFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $subject,
                style: .subject,
                state: viewModel.subjectState,
                alertText: viewModel.subjectAnnounceState
            )
        )
        .onChange(of: subject) { newSubject in
            if newSubject.count > 10 {
                subject = String(newSubject.prefix(10))
            }
            
            viewModel.verifySubject(
                oldText: oldSubject,
                newText: newSubject,
                isSubjectFocused: isSubjectFocused
            )
            
            oldSubject = viewModel.subject
        }
        .onChange(of: isSubjectFocused) { isFocused in
            viewModel.handleSubjectFocusChange(
                isSubjectFocused: isSubjectFocused,
                text: subject
            )
        }
    }
}
