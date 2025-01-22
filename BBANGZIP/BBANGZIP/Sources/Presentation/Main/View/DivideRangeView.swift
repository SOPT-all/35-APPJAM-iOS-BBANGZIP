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
        viewModel: DivideRangeViewModel = DivideRangeViewModel(pieceCount: 6),
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
                    
//                    registerButton(for: piece)
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
                        startRangeTextField(for: piece)
                        
                        endRangeTextField(for: piece)
                    }
                    
                    deadlineButton
                }
            }
        }
    }
    
    private func startRangeTextField(for index: Int) -> some View {
        TextField(
            "시작 페이지",
            text: $viewModel.startRangeStrings[index]
        )
        .focused($isStartRangeFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.startRangeStrings[index],
                style: .studyRange,
                state: viewModel.startRangeStates[index],
                alertText: viewModel.startRangeAnnounceStates[index]
            )
        )
        .padding(
            .bottom,
            16
        )
        .keyboardType(.decimalPad)
        .onChange(of: viewModel.startRangeStrings[index]) { newRange in
            if newRange.count > 4 && !newRange.hasSuffix("p") {
                viewModel.startRangeStrings[index] = String(newRange.prefix(4))
            }
            
            viewModel.verifyStartRange(
                for: index,
                newText: newRange,
                isStartRangeFocused: isStartRangeFocused
            )
        }
        .onChange(of: isStartRangeFocused) { isStartRangeFocused in
            viewModel.handleStartRangeFocusChange(
                for: index,
                newText: viewModel.startRangeStrings[index],
                isStartRangeFocused: isStartRangeFocused
            )
        }
    }
    
    private func endRangeTextField(for index: Int) -> some View {
        TextField(
            "종료 페이지",
            text: $viewModel.endRangeStrings[index]
        )
        .focused($isEndRangeFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.endRangeStrings[index],
                style: .studyRange,
                state: viewModel.endRangeStates[index],
                alertText: viewModel.endRangeAnnounceStates[index]
            )
        )
        .padding(
            .bottom,
            16
        )
        .keyboardType(.decimalPad)
        .onChange(of: viewModel.endRangeStrings[index]) { newRange in
            if newRange.count > 4 && !newRange.hasSuffix("p") {
                viewModel.endRangeStrings[index] = String(newRange.prefix(4))
            }
            
            viewModel.verifyEndRange(
                for: index,
                newText: newRange,
                isEndRangeFocused: isEndRangeFocused
            )
        }
        .onChange(of: isEndRangeFocused) { isEndRangeFocused in
            viewModel.handleEndRangeFocusChange(
                for: index,
                newText: viewModel.endRangeStrings[index],
                isEndRangeFocused: isEndRangeFocused
            )
        }
    }
    
    private var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 까지"
        return formatter.string(from: selectedDate)
    }
    
    private var deadlineButton: some View {
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
    
    private func registerButton(for index: Int) -> some View {
        Button("저장하기") {
            // TODO: 화면 전환해야 할 다음 뷰로 연결
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.plus),
                !isStartRangeFocused && !isEndRangeFocused && viewModel.isEndRangeValid[index] && viewModel.isStartRangeValid[index]
            )
        )
        .disabled(
            isStartRangeFocused && isEndRangeFocused && !viewModel.isEndRangeValid[index] && !viewModel.isStartRangeValid[index]
        )
    }
}


#Preview {
    DivideRangeView(pieceCount: 10)
}
