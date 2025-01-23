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
    
    init(
        viewModel: AddSubjectViewModel = AddSubjectViewModel()
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack (spacing: 16) {
            HStack {
                CustomText(
                    "과목명",
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
                
                Spacer()
            }
            
            //            subjectTextField
            
            Spacer()
            
            Button("추가하기") {
                viewModel.addSubject()
                print("dd")
            }
            .buttonStyle(
                SolidIconButton(
                    buttonImage: Image(.plus),
                    viewModel.isEnabled
                )
            )
            .disabled(!viewModel.isEnabled)
        }
        .padding(
            .horizontal,
            20
        )
        .padding(
            .top,
            16
        )
        .padding(
            .bottom,
            8
        )
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

#Preview {
    AddSubjectView()
}
