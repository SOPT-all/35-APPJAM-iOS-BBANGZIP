//
//  SubjectAddView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectAddView: View {
    @StateObject private var viewModel: SubjectAddViewModel
    
    init(
        viewModel: SubjectAddViewModel = SubjectAddViewModel()
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
            
            subjectTextField
            
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
    
    var subjectTextField: some View {
        TextField(
            "예) 거시경제학",
            text: $viewModel.subject
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.subject,
                style: .subject,
                state: viewModel.state,
                alertText: viewModel.alertCase
            )
        )
    }
}

#Preview {
    SubjectAddView()
}
