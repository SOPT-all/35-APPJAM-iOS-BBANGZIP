//
//  addStudyView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct AddStudyView: View {
    @StateObject var viewModel: AddStudyViewModel
    @State private var isRangeLocked: Bool = false
    @FocusState private var isStudyContentFocused: Bool
    @FocusState private var isStartRangeFocused: Bool
    @FocusState private var isEndRangeFocused: Bool
    
    init(viewModel: AddStudyViewModel,
         isBottomSheetPresented: Bool = false,
         isButtonTapped: Bool = false
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                VStack{
                    ZStack{
                        subjectTitle
                        
                        HStack {
                            backButton
                                .padding(16)
                            Spacer()
                        }
                    }
                    .padding(
                        .bottom,
                        16
                    )
                    
                    VStack(spacing: 0) {
                        dateTitle
                        
                        dateTextField
                        
                        studyContentTitle
                        
                        studyContentField
                        
                        studyRangeTitle
                        
                        HStack(spacing: 20) {
                            startRangeTextField
                            
                            endRangeTextField
                        }
                        
                        divideButton
                        
                        tipText
                        
                        Spacer()
                        
                        registerButton
                    }
                    .padding(
                        .horizontal,
                        20
                    )
                }
                .ignoresSafeArea(.keyboard)
                .bottomSheet(
                    isShowing: $viewModel.isDatePickerPresented,
                    height: 453
                ) {
                    ExamPickerBottomSheet(
                        isPresented: $viewModel.isDatePickerPresented,
                        selectedYear: $viewModel.selectedYear,
                        selectedMonth: $viewModel.selectedMonth,
                        selectedDay: $viewModel.selectedDay,
                        isButtonTapped: $viewModel.isButtonTapped
                    )
                }
                .bottomSheet(
                    isShowing: $viewModel.isDividerPresented,
                    height: 449
                ) {
                    SetPieceBottomSheet(
                        isPresented: $viewModel.isDividerPresented,
                        startPage: Int(viewModel.startRangeString.dropLast()) ?? 0,
                        endPage: Int(viewModel.endRangeString.dropLast()) ?? 0,
                        totalDays: viewModel.daysUntilExam,
                        addStudyViewModel: viewModel
                    )
                }
            }
        }
    }
    
    // TODO: 뒤로가기 버튼 ToolBar로 리팩토링 필요
    private var backButton: some View {
        HStack {
            Image(.chevronLeftThickSmall)
                .renderingMode(.template)
                .foregroundStyle(Color(.labelAlternative))
        }
    }
    
    private var subjectTitle: some View {
        CustomText(
            "경제통계학",
            fontType: .headline1Bold,
            color: Color(.labelNeutral)
        )
    }
    
    private var dateTitle: some View {
        HStack {
            CustomText(
                "시험 일자",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            16
        )
    }
    
    private var dateTextField: some View {
        TextField(
            "시험 일자 입력",
            text: .constant(viewModel.formattedDate)
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: .constant(viewModel.formattedDate),
                style: .date,
                state: viewModel.dateState
            )
        )
        .disabled(true)
        .onTapGesture {
            hideKeyboard()
            viewModel.selectedBottomSheetType = .examDate
            viewModel.isDatePickerPresented = true
        }
        .padding(
            .bottom,
            50
        )
        .onChange(of: viewModel.isButtonTapped) { isTapped in
            if isTapped {
                updateDateTextField()
            }
        }
        .onChange(of: viewModel.isDatePickerPresented) { isPresented in
            if isPresented {
                viewModel.isButtonTapped = false
            }
        }
    }
    
    private var studyContentTitle: some View {
        HStack {
            CustomText(
                "학습 내용",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            16
        )
    }
    
    private var studyContentField: some View {
        TextField(
            "예) 교재 이름, PPT 1과",
            text: $viewModel.studyContent
        )
        .focused($isStudyContentFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.studyContent,
                style: .studyContent,
                state: viewModel.contentState,
                alertText: viewModel.contentAnnounceState
            )
        )
        .onChange(of: viewModel.studyContent) { newContent in
            if newContent.count > 20 {
                viewModel.studyContent = String(newContent.prefix(20))
            }
            
            viewModel.verifyStudyContent(
                newText: newContent,
                isStudyContentFocused: isStudyContentFocused
            )
        }
        .onChange(of: isStudyContentFocused) { isStudyContentFocused in
            viewModel.handleStudyContentFocusChange(
                newText: viewModel.studyContent,
                isStudyContentFocused: isStudyContentFocused
            )
        }
        .padding(
            .bottom,
            32
        )
    }
    
    private var studyRangeTitle: some View {
        HStack {
            CustomText(
                "학습 범위",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            16
        )
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
            if newRange.count > 3 && !newRange.hasSuffix("p") {
                viewModel.startRangeString = String(newRange.prefix(3))
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
            if newRange.count > 3 && !newRange.hasSuffix("p") {
                viewModel.endRangeString = String(newRange.prefix(3))
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
    
    private var divideButton: some View {
        Button("쪼개서 공부하기") {
            hideKeyboard()
            viewModel.isDividerPresented = true
        }
        .buttonStyle(
            OutlinedMediumButton(
                viewModel.isStudyContentValid && viewModel.isEndRangeValid && viewModel.isStartRangeValid && !isEndRangeFocused && !isStartRangeFocused && !isStudyContentFocused
            )
        )
        .padding(
            .bottom,
            8
        )
        .disabled(
            !viewModel.isStudyContentValid && !viewModel.isEndRangeValid && !viewModel.isStartRangeValid && isEndRangeFocused && isStartRangeFocused && isStudyContentFocused
        )
        .buttonStyle(PressedButtonStyle())
    }
    
    private var tipText: some View {
        HStack {
            CustomText(
                "[Tip] 입력하신 학습 범위를 자동으로 분배하여\n꾸준히 공부할 수 있도록 학습 계획을 세워드려요!",
                fontType: .caption2Bold,
                color: Color(.labelAssistive)
            )
            
            Spacer()
        }
    }
    
    private var registerButton: some View {
        Button("공부 내용 등록하기") {
            // TODO: 화면 전환해야 할 다음 뷰로 연결
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.plus),
                viewModel.isStudyContentValid && viewModel.isEndRangeValid && viewModel.isStartRangeValid && !isEndRangeFocused && !isStartRangeFocused && !isStudyContentFocused
            )
        )
        .disabled(
            !viewModel.isStudyContentValid && !viewModel.isEndRangeValid && !viewModel.isStartRangeValid && isEndRangeFocused && isStartRangeFocused && isStudyContentFocused
        )
    }
    
    private func updateDateTextField() {
        let calendar = Calendar.current
        viewModel.date = calendar.date(
            from: DateComponents(
                year: viewModel.selectedYear,
                month: viewModel.selectedMonth,
                day: viewModel.selectedDay
            )
        )
    }
}
