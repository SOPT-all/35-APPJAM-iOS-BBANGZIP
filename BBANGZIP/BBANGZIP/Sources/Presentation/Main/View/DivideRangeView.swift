//
//  DivideRangeView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum FocusField: Hashable {
    case startRange(Int)
    case endRange(Int)
}

struct DivideRangeView: View {
    @StateObject var viewModel: DivideRangeViewModel
    @FocusState private var startFocusedField: FocusField?
    @FocusState private var endFocusedField: FocusField?
    @State private var selectedPieceIndex: Int? = nil
    
    init(
        pieceCount: Int,
        startPage: Int,
        endPage: Int,
        totalDays: Int
    ) {
        _viewModel = StateObject(
            wrappedValue: DivideRangeViewModel(
                pieceCount: pieceCount,
                startPage: startPage,
                endPage: endPage,
                totalDays: totalDays
            )
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
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
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    .ignoresSafeArea(.keyboard)
                }
            }
        }
        .bottomSheet(
            isShowing: $viewModel.isDatePickerPresented,
            height: 453
        ) {
            if let index = selectedPieceIndex {
                StudyDeadlinePickerBottomSheet(
                    isPresented: $viewModel.isDatePickerPresented,
                    selectedYear: $viewModel.selectedYears[index],
                    selectedMonth: $viewModel.selectedMonths[index],
                    selectedDay: $viewModel.selectedDays[index],
                    selectedDeadline: $viewModel.deadlineDates[index],
                    isButtonTapped: $viewModel.isButtonTapped[index]
                )
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
                Chip(type: .page(viewModel.fixedStartPage))
                
                CustomText(
                    "부터",
                    fontType: .label1Bold,
                    color: Color(.labelAlternative)
                )
                .padding(.trailing, 4)
                
                Chip(type: .page(viewModel.fixedEndPage))
                
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
            ForEach(viewModel.pieces, id: \.self) { piece in
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
                        startRangeTextField(for: piece - 1)
                        
                        endRangeTextField(for: piece - 1)
                    }
                    
                    deadlineButton(for: viewModel.deadlineDates[piece - 1], index: piece - 1)
                }
            }
        }
    }
    
    private func startRangeTextField(for index: Int) -> some View {
        TextField(
            "시작 페이지",
            text: $viewModel.startRangeStrings[index]
        )
        .focused($startFocusedField, equals: .startRange(index))
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
                isStartRangeFocused: startFocusedField == .startRange(index)
            )
        }
        .onChange(of: startFocusedField) { newFocus in
            viewModel.handleStartRangeFocusChange(
                for: index,
                newText: viewModel.startRangeStrings[index],
                isStartRangeFocused: newFocus == .startRange(index)
            )
        }
    }
    
    private func endRangeTextField(for index: Int) -> some View {
        TextField(
            "종료 페이지",
            text: $viewModel.endRangeStrings[index]
        )
        .focused($endFocusedField, equals: .endRange(index))
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
                isEndRangeFocused: endFocusedField == .endRange(index)
            )
        }
        .onChange(of: endFocusedField) { newFocus in
            viewModel.handleEndRangeFocusChange(
                for: index,
                newText: viewModel.endRangeStrings[index],
                isEndRangeFocused: newFocus == .endRange(index)
            )
        }
    }
    
    private func deadlineButton(
        for dateRange: String,
        index: Int
    ) -> some View {
        Button(
            action: {
                selectedPieceIndex = index
                viewModel.isDatePickerPresented = true
            }
        ) {
            HStack {
                Image(.calenderSmall)
                Text(dateRange)
            }
        }
        .buttonStyle(OutlinedMediumButton())
        .padding(
            .bottom,
            8
        )
        .buttonStyle(PressedButtonStyle())
        .onChange(of: viewModel.isDatePickerPresented) { isPresented in
            if !isPresented {
                viewModel.deadlineDates[index] = "\(viewModel.selectedYears[index])년 \(viewModel.selectedMonths[index])월 \(viewModel.selectedDays[index])일"
            }
        }
    }
    
    //    private func registerButton(for index: Int) -> some View {
    //        Button("저장하기") {
    //            // TODO: 화면 전환해야 할 다음 뷰로 연결
    //        }
    //        .buttonStyle(
    //            SolidIconButton(
    //                buttonImage: Image(.plus),
    //                !isStartRangeFocused && !isEndRangeFocused && viewModel.isEndRangeValid[index] && viewModel.isStartRangeValid[index]
    //            )
    //        )
    //        .disabled(
    //            isStartRangeFocused && isEndRangeFocused && !viewModel.isEndRangeValid[index] && !viewModel.isStartRangeValid[index]
    //        )
    //    }
}
