//
//  AddSubjectView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct AddSubjectView: View {
    @StateObject private var viewModel: AddSubjectViewModel
    @FocusState private var isSubjectFocused: Bool
    @SwiftUI.Environment(\.dismiss) private var dismiss
    
    init(
        viewModel: AddSubjectViewModel
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            Color(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
            
            VStack (spacing: 16) {
                CustomNavigationBar(
                    showBackButton: true,
                    showMenu: false,
                    title: "과목 추가하기",
                    backgroundColor: Color(.backgroundNormal)
                )
                
                HStack {
                    CustomText(
                        "과목명",
                        fontType: .body1Bold,
                        color: Color(.labelNormal)
                    )
                    
                    Spacer()
                }
                .padding(
                    .horizontal,
                    20
                )
                
                subjectTextField
                    .padding(
                        .horizontal,
                        20
                    )
                
                Spacer()
                
                Button("추가하기") {
                    Task {
                        await viewModel.addSubject(subjectName: viewModel.subject)
                    }
                }
                .buttonStyle(
                    SolidIconButton(
                        buttonImage: Image(.plus),
                        viewModel.isEnabled
                    )
                )
                .disabled(!viewModel.isEnabled)
                .padding(
                    .bottom,
                    8
                )
                .padding(
                    .horizontal,
                    20
                )
            }
        }
        .navigationBarHidden(true)
        .onChange(of: viewModel.shouldDismiss) {
            shouldDismiss in
            if shouldDismiss {
                dismiss()
            }
        }
    }
    
    private var subjectTextField: some View {
        TextField(
            "예) 거시경제학",
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
