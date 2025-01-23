//
//  CustomNavigationBar.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomNavigationBar: View {
    @SwiftUI.Environment(\.dismiss) var dismiss
    private let showBackButton: Bool
    private let showMenu: Bool
    private let title: String
    private let backgroundColor: Color?
    @EnvironmentObject private var viewModel: SubjectDetailViewModel
    
    init(
        showBackButton: Bool,
        showMenu: Bool,
        title: String,
        backgroundColor: Color
    ) {
        self.showBackButton = showBackButton
        self.showMenu = showMenu
        self.title = title
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea(edges: .top)
            
            HStack {
                
                if showBackButton {
                    backButton
                } else {
                    ZStack {
                        
                    }
                    .frame(
                        width: 24,
                        height: 24
                    )
                }
                
                Spacer()
                
                CustomText(
                    title,
                    fontType: .headline1Bold,
                    color: Color(.labelNeutral)
                )
                
                Spacer()
                
                if showMenu {
                    kebabButton
                } else {
                    ZStack {
                        
                    }
                    .frame(
                        width: 24,
                        height: 24
                    )
                }
            }
            .padding(.horizontal)
            
        }
        .frame(height: 56)
    }
}

extension CustomNavigationBar {
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(.chevronLeftThickSmall)
                .resizable()
                .frame(
                    width: 24,
                    height: 24
                )
        }
    }
    
    private var kebabButton: some View {
        // TODO: custom으로 수정 필요
        Menu {
            NavigationLink(
                destination: AddMotivationMessageView(
                    viewModel: AddMotivationMessageViewModel(
                        changeNameUseCase: DefaultChangeNameUseCase(repository: DefaultMessageRepository()),
                        parentViewModel: SubjectDetailViewModel(
                            filterExamUseCase: DefaultFilterExamUseCase(
                                examRepository: DefaultExamRepository()
                            ),
                            subjectId: viewModel.subjectId
                        )
                    )
                )
            ) {
                CustomText(
                    "각오 한 마디 작성하기",
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
            }
            .buttonStyle(PressedButtonStyle())
                               
            NavigationLink(destination: ChangeSubjectNameView()) {
                CustomText(
                    "과목명 수정하기",
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
            }
            .buttonStyle(PressedButtonStyle())
            
        } label: {
            Image(.dotsVertical)
                .resizable()
                .frame(
                    width: 24,
                    height: 24
                )
        }
    }
}
