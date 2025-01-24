//
//  ChangeSubjectNameView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ChangeSubjectNameView: View {
    @SwiftUI.Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: ChangeSubjectNameViewModel
    @FocusState private var isSubjectFocused: Bool
    private let subjectName: String

    init(
        viewModel: ChangeSubjectNameViewModel,
        subjectName: String
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.subjectName = subjectName
    }

    var body: some View {
        ZStack {
            Color(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }

            VStack {
                CustomNavigationBar(
                    showBackButton: true,
                    showMenu: false,
                    title: "과목명 수정하기",
                    backgroundColor: Color(.backgroundNormal)
                )

                inputSection
                    .padding(
                        .top,
                        48
                    )
                    .padding(
                        .horizontal,
                        20
                    )

                Spacer()
            }

            VStack {
                Spacer()

                Button("등록하기") {
                    Task {
                        await viewModel.changeSubjectName()
                    }
                }
                .buttonStyle(SolidButton(viewModel.isButtonEnabled))
                .disabled(!viewModel.isButtonEnabled)
                .padding(
                    .bottom,
                    36
                )
            }
            .padding(.horizontal, 20)
            .ignoresSafeArea(edges: .bottom)
        }
        .navigationBarHidden(true)
        .onChange(of: viewModel.shouldDismiss) {
            shouldDismiss in
            if shouldDismiss {
                dismiss()
            }
        }
    }

    var inputSection: some View {
        VStack(spacing: 16){
            HStack {
                CustomText(
                    "과목명",
                    fontType: .body1Bold
                )

                Spacer()
            }

            TextField(
                subjectName,
                text: $viewModel.subject
            )
            .focused($isSubjectFocused)
            .textFieldStyle(
                CustomTextFieldStyle(
                    text: $viewModel.subject,
                    style: .subject,
                    state: viewModel.subjectState,
                    alertText: viewModel.subjectAnnounceState
                )
            )
            .onChange(of: viewModel.subject) { newSubject in
                if newSubject.count > 10 {
                    viewModel.subject = String(newSubject.prefix(10))
                }
                
                viewModel.verifySubject(
                    newText: newSubject,
                    isSubjectFocused: isSubjectFocused
                )
            }
            .onChange(of: isSubjectFocused) { isFocused in
                viewModel.handleSubjectFocusChange(
                    newText: viewModel.subject,
                    isSubjectFocused: isSubjectFocused
                )
            }
        }
    }
}
