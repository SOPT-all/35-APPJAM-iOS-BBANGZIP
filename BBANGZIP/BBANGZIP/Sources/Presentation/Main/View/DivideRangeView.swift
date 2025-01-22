//
//  DivideRangeView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct DivideRangeView: View {
    @StateObject var viewModel: DivideRangeViewModel
    @FocusState private var isStartRangeFocused: Bool
    @FocusState private var isEndRangeFocused: Bool
    @State private var selectedDate: Date = Date()
    let pieceCount: Int
    
    private var pieces: [Int] {
        Array(1...pieceCount)
    }
    
    init(
        viewModel: DivideRangeViewModel = DivideRangeViewModel(),
        pieceCount: Int
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.pieceCount = pieceCount
    }
    
    var body: some View {
        CustomNavigationBar(
            showBackButton: true,
            showMenu: false,
            title: "학습 범위 나누기",
            backgroundColor: Color(.clear)
        )
        .navigationBarHidden(true)
        
        ScrollView {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                VStack(spacing: 32) {
                    entireRange
                    
                    Divider()
                    
                    piece
                    
                    registerButton
                }
                .padding(.horizontal, 20)
                .ignoresSafeArea(.keyboard)
            }
        }
    }
    
    private var entireRange: some View {
        VStack {
            HStack {
                CustomText(
                    "학습 내용",
                    fontType: .headline2Bold,
                    color: Color(.labelNormal)
                )
                
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack(spacing: 4) {
                Chip(type: .page(40))
                
                CustomText(
                    "부터",
                    fontType: .label1Bold,
                    color: Color(.labelAlternative)
                )
                .padding(.trailing, 4)
                
                Chip(type: .page(110))
                
                CustomText(
                    "까지",
                    fontType: .label1Bold,
                    color: Color(.labelAlternative)
                )
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color(.backgroundAlternative))
                .customShadow(.emphasize)
        )
    }
    
    private var piece: some View {
        VStack(spacing: 16) {
            ForEach(pieces, id: \.self) { piece in
                VStack(spacing: 16) {
                    HStack {
                        CustomText(
                            "\(piece)조각",
                            fontType: .body1Bold,
                            color: Color(.labelNormal)
                        )
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 20) {
                        startRangeTextField
                        
                        endRangeTextField
                    }
                    
                    dueDateButton
                }
            }
        }
    }
    
    private var startRangeTextField: some View {
        TextField(
            "시작 페이지",
            text: $viewModel.startRangeString
        )
        .focused($isStartRangeFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.startRangeString,
                style: .studyRange,
                state: viewModel.startRangeState,
                alertText: viewModel.startRangeAnnounceState
            )
        )
        .padding(
            .bottom,
            16
        )
        .keyboardType(.decimalPad)
        .onChange(of: viewModel.startRangeString) { newRange in
            if newRange.count > 4 && !newRange.hasSuffix("p") {
                viewModel.startRangeString = String(newRange.prefix(4))
            }
            
            viewModel.verifyStartRange(
                newText: newRange,
                isStartRangeFocused: isStartRangeFocused
            )
        }
        .onChange(of: isStartRangeFocused) { isStartRangeFocused in
            viewModel.handleStartRangeFocusChange(
                newText: viewModel.startRangeString,
                isStartRangeFocused: isStartRangeFocused
            )
        }
    }
    
    private var endRangeTextField: some View {
        TextField(
            "종료 페이지",
            text: $viewModel.endRangeString
        )
        .focused($isEndRangeFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.endRangeString,
                style: .studyRange,
                state: viewModel.endRangeState,
                alertText: viewModel.endRangeAnnounceState
            )
        )
        .padding(
            .bottom,
            16
        )
        .keyboardType(.decimalPad)
        .onChange(of: viewModel.endRangeString) { newRange in
            if newRange.count > 4 && !newRange.hasSuffix("p") {
                viewModel.endRangeString = String(newRange.prefix(4))
            }
            
            viewModel.verifyEndRange(
                newText: newRange,
                isEndRangeFocused: isEndRangeFocused
            )
        }
        .onChange(of: isEndRangeFocused) { isEndRangeFocused in
            viewModel.handleEndRangeFocusChange(
                newText: viewModel.endRangeString,
                isEndRangeFocused: isEndRangeFocused
            )
        }
    }
    
    private var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 까지"
        return formatter.string(from: selectedDate)
    }
    
    private var dueDateButton: some View {
        Button(
            action: {
                viewModel.isDatePickerPresented = true
            }
        ) {
            HStack {
                Image(.calenderSmall)
                Text(dateFormatted)
            }
        }
        .buttonStyle(
            OutlinedMediumButton()
        )
        .padding(
            .bottom,
            8
        )
    }
    
    private var registerButton: some View {
        Button("저장하기") {
            // TODO: 화면 전환해야 할 다음 뷰로 연결
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.plus),
                !isStartRangeFocused && !isEndRangeFocused && viewModel.isEndRangeValid && viewModel.isStartRangeValid
            )
        )
        .disabled(
            isStartRangeFocused && isEndRangeFocused && !viewModel.isEndRangeValid && !viewModel.isStartRangeValid
        )
    }
}


#Preview {
    DivideRangeView(pieceCount: 10)
}
