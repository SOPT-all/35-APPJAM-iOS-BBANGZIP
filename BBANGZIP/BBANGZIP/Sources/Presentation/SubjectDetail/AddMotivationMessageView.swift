//
//  MotivationMessageView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct AddMotivationMessageView: View {
    @SwiftUI.Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: AddMotivationMessageViewModel
    @FocusState private var isMessageFocused: Bool
    
    init(
        viewModel: AddMotivationMessageViewModel
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
            
            VStack {
                CustomNavigationBar(
                    showBackButton: true,
                    showMenu: false,
                    title: "각오 한 마디 작성하기",
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
                        await viewModel.changeMotivationMessage()
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
                    "사장님의 각오 한 마디를\n작성해 보세요",
                    fontType: .headline1Bold
                )
                
                Spacer()
            }
            
            TextField(
                "예) 이번엔 열심히 공부해서 빵점 탈출!",
                text: $viewModel.message
            )
            .textFieldStyle(
                CustomTextFieldStyle(
                    text: $viewModel.message,
                    style: .message,
                    state: viewModel.messageState,
                    alertText: viewModel.messageAnnounceState
                )
            )
            .onChange(of: viewModel.message) { newMessage in
                if newMessage.count > 25 {
                    viewModel.message = String(newMessage.prefix(25))
                }
                
                viewModel.verifyMessage(
                    newText: newMessage,
                    isMessageFocused: isMessageFocused
                )
            }
            .onChange(of: isMessageFocused) { isMessageFocused in
                viewModel.handleMessageFocusChange(
                    newText: viewModel.message,
                    isMessageFocused: isMessageFocused
                )
            }
        }
    }
}
