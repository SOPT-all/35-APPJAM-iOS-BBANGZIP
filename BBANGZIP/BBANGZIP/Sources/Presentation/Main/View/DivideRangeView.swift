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

struct StudyRange: Encodable {
    let subjectID: Int = 1 // temporary
    let examName: String = "" // temporary
    let studyContents, examDate: String
    let pieceList: [PieceList]

    enum CodingKeys: String, CodingKey {
        case subjectID = "subjectId"
        case examName, studyContents, examDate, pieceList
    }
}

struct PieceList: Encodable {
    let startPage, finishPage: Int
    let deadline: String // "YYYY-MM-DD"

    enum CodingKeys: String, CodingKey {
        case finishPage = "endPage"
        case startPage, deadline
    }
}

struct DivideRangeView: View {
    @SwiftUI.Environment(\.dismiss) var dismiss
    @StateObject var viewModel: DivideRangeViewModel
    @ObservedObject var addStudyViewModel: AddStudyViewModel
    
    @FocusState private var startFocusedField: FocusField?
    @FocusState private var endFocusedField: FocusField?
    @State private var selectedPieceIndex: Int? = nil

    @State private var studyRange: StudyRange? =
        StudyRange(
            studyContents: "",
            examDate: "",
            pieceList: []
        )

    init(
        viewModel: DivideRangeViewModel,
        addStudyViewModel: AddStudyViewModel,
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
        self.addStudyViewModel = addStudyViewModel
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
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    .ignoresSafeArea(.keyboard)
                }
                .padding(.bottom, 20)
            }
            .scrollIndicators(.never)

            registerButton
                .padding(.horizontal, 20)
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
                    isButtonTapped: $viewModel.isButtonTapped[index],
                    fixedExamDate: viewModel.fixedExamDate
                )
            }
        }
        .onDisappear {
            addStudyViewModel.isDividerPresented = false
        }
        // TODO: 이전 바 되돌아갈떄 바텀시트 다시 안나오도록 
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
            if newRange.count > 3 && !newRange.hasSuffix("p") {
                viewModel.startRangeStrings[index] = String(newRange.prefix(3))
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
            if newRange.count > 3 && !newRange.hasSuffix("p") {
                viewModel.endRangeStrings[index] = String(newRange.prefix(3))
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
            .applyFont(font: .body2Bold)
            .foregroundStyle(Color(.primaryNormal))
            .padding(
                .vertical,
                8
            )
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        Color(.lineStrong),
                        lineWidth: 1
                    )
            )
            .buttonStyle(PressedButtonStyle())
            .onChange(of: viewModel.isDatePickerPresented) { isPresented in
                if !isPresented, viewModel.isButtonTapped[index] {
                    viewModel.deadlineDates[index] = "\(viewModel.selectedYears[index])년 \(viewModel.selectedMonths[index])월 \(viewModel.selectedDays[index])일 까지"
                }
            }
            
        
    }

    private func printStudyRange() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(studyRange)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("studyRange:\n\(jsonString)")
            }
        } catch {
            print("studyRange 인코딩 실패: \(error)")
        }
    }

    private func saveStudyRange() {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy년 M월 d일 까지"
        inputDateFormatter.locale = Locale(identifier: "ko_KR")

        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy-MM-dd"

        let updatedPieceList = (0..<viewModel.pieces.count).compactMap { index -> PieceList? in
            guard let startPage = Int(viewModel.startRangeStrings[index].dropLast()),
                  let endPage = Int(viewModel.endRangeStrings[index].dropLast()) else {
                return nil
            }

            let originalDeadline = viewModel.deadlineDates[index]

            let formattedDeadline: String
            if let date = inputDateFormatter.date(from: originalDeadline) {
                formattedDeadline = outputDateFormatter.string(from: date)
            } else {
                formattedDeadline = ""
            }

            return PieceList(
                startPage: startPage,
                finishPage: endPage,
                deadline: formattedDeadline
            )
        }

        let formattedExamDate = outputDateFormatter.string(from: viewModel.fixedExamDate)
        studyRange = StudyRange(
            studyContents: addStudyViewModel.studyContent,
            examDate: formattedExamDate,
            pieceList: updatedPieceList
        )
        
        studyRange = StudyRange(
                studyContents: addStudyViewModel.studyContent,
                examDate: formattedExamDate,
                pieceList: updatedPieceList
        )
            
        if let range = studyRange {
            addStudyViewModel.updateStudyRange(range)
        }
    }


    private var registerButton: some View {
        Button("저장하기") {
            saveStudyRange()
            printStudyRange()
            
            if let range = self.studyRange {
                addStudyViewModel.updateStudyRange(range)
                print("StudyRange Data:")
                print("studyContents: \(range.studyContents)")
                print("examDate: \(range.examDate)")
                print("pieceList count: \(range.pieceList.count)")
                
                // 각 piece의 상세 정보 출력
                for (index, piece) in range.pieceList.enumerated() {
                    print("Piece \(index + 1):")
                    print("  startPage: \(piece.startPage)")
                    print("  finishPage: \(piece.finishPage)")
                    print("  deadline: \(piece.deadline)")
                }
            }
                    
            dismiss()
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.plus),
                !viewModel.allRangesValid)
        )
        .disabled(viewModel.allRangesValid)
    }

}
