//
//  AddStudyViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class AddStudyViewModel: ObservableObject {
    private let addStudyPieceUseCase: AddStudyPieceUseCase
    @Published var date: Date? {
        didSet {
            calculateDaysUntilExam()
        }
    }
    @Published var studyContent: String
    @Published var startRange: Int = 0
    @Published var endRange: Int = 0
    @Published var startRangeString: String
    @Published var endRangeString: String
    @Published var dateState: TextFieldState
    @Published var contentState: TextFieldState
    @Published var contentAnnounceState: StudyContentTextFieldAlertCase?
    @Published var startRangeState: TextFieldState
    @Published var startRangeAnnounceState: StudyRangeTextFieldAlertCase?
    @Published var endRangeState: TextFieldState
    @Published var endRangeAnnounceState: StudyRangeTextFieldAlertCase?
    @Published var isStudyContentValid: Bool = false
    @Published var isStartRangeValid: Bool = false
    @Published var isEndRangeValid: Bool = false

    @Published var isDatePickerPresented = false
    @Published var isDividerPresented = false
    @Published var selectedBottomSheetType: BottomSheetType?
    @Published var selectedYear: Int
    @Published var selectedMonth: Int
    @Published var selectedDay: Int
    @Published var isButtonTapped: Bool = false
    @Published var daysUntilExam: Int = 0
    @Published var dividedExamDate: String = ""
    @Published var dividedPieceList: [AddStudyPieceDTO] = []
        
    var formattedDate: String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: date)
    }
    
    init(
        addStudyPieceUseCase: AddStudyPieceUseCase,
        pieceCount: Int = 1,
        date: Date? = nil,
        studyContent: String = "",
        startRange: Int = 0,
        endRange: Int = 0,
        dateState: TextFieldState = .defaultState,
        contentState: TextFieldState = .defaultState,
        contentAnnounceState: StudyContentTextFieldAlertCase? = .alert,
        startRangeState: TextFieldState = .defaultState,
        startRangeAnnounceState: StudyRangeTextFieldAlertCase? = .startAlert,
        endRangeState: TextFieldState = .defaultState,
        endRangeAnnounceState: StudyRangeTextFieldAlertCase? = .endAlert
    ) {
        self.addStudyPieceUseCase = addStudyPieceUseCase
        self.date = date
        self.studyContent = studyContent
        self.startRange = startRange
        self.endRange = endRange
        self.startRangeString = ""
        self.endRangeString = ""
        self.dateState = dateState
        self.contentState = contentState
        self.contentAnnounceState = contentAnnounceState
        self.startRangeState = startRangeState
        self.startRangeAnnounceState = startRangeAnnounceState
        self.endRangeState = endRangeState
        self.endRangeAnnounceState = endRangeAnnounceState
        
        let currentDate = Date()
        let calendar = Calendar.current
        self.selectedYear = calendar.component(.year, from: currentDate)
        self.selectedMonth = calendar.component(.month, from: currentDate)
        self.selectedDay = calendar.component(.day, from: currentDate)
        self.isButtonTapped = isButtonTapped
        
        calculateDaysUntilExam()
    }
    
    @MainActor
    func addStudyPiece() async {
        do {
            try await addStudyPieceUseCase.execute(
                subjectId: 74,
                examName: "내가",
                studyContents: studyContent,
                examDate: dividedExamDate,
                pieceList: dividedPieceList
            )
            // ... 성공 처리
        } catch {
            // ... 에러 처리
        }
    }
    
    private func calculateDaysUntilExam() {
        guard let examDate = date else {
            daysUntilExam = 0
            return
        }
        let calendar = Calendar.current
        let currentDate = Date()
        
        let components = calendar.dateComponents([.day], from: currentDate, to: examDate)
        daysUntilExam = max(components.day ?? 0, 0)
    }
    
    func verifyStudyContent(
        newText: String,
        isStudyContentFocused: Bool
    ) {
        if isStudyContentFocused {
            contentState = .typing
            
            if newText.isEmpty {
                contentState = .defaultState
                contentAnnounceState = .alert
                isStudyContentValid = false
            } else {
                if newText.isValidStudyContent {
                    contentState = .typing
                    contentAnnounceState = .enable
                    isStudyContentValid = true
                } else {
                    contentState = .alert
                    contentAnnounceState = .alert
                    isStudyContentValid = false
                }
            }
        } else if newText.isEmpty {
            contentState = .defaultState
            contentAnnounceState = .alert
            isStudyContentValid = false
        }
    }
    
    func handleStudyContentFocusChange(
        newText: String,
        isStudyContentFocused: Bool
    ) {
        if !isStudyContentFocused {
            if newText.isEmpty {
                contentState = .defaultState
                isStudyContentValid = false
            } else if newText.isValidStudyContent {
                contentState = .field
                contentAnnounceState = .enable
                isStudyContentValid = true
            } else {
                contentState = .alert
                contentAnnounceState = .alert
                isStudyContentValid = false
            }
        } else {
            contentState = .placeholder
            isStudyContentValid = false
        }
    }
    
    func verifyStartRange(
        newText: String,
        isStartRangeFocused: Bool
    ) {
        if isStartRangeFocused {
            startRangeState = .typing
            
            if newText.isEmpty {
                startRangeState = .defaultState
                startRangeAnnounceState = .startAlert
                isStartRangeValid = false
            } else {
                if newText.isValidStudyRange {
                    startRangeState = .typing
                    startRangeAnnounceState = .startAlert
                    isStartRangeValid = true
                } else {
                    startRangeState = .alert
                    startRangeAnnounceState = .startAlert
                    isStartRangeValid = false
                }
            }
        } else if newText.isEmpty {
            startRangeState = .defaultState
            startRangeAnnounceState = .startAlert
            isStartRangeValid = false
        }
    }
    
    func verifyEndRange(
        newText: String,
        isEndRangeFocused: Bool
    ) {
        if isEndRangeFocused {
            endRangeState = .typing
            
            if newText.isEmpty {
                endRangeState = .defaultState
                endRangeAnnounceState = .endAlert
                isEndRangeValid = false
            } else {
                if newText.isValidStudyRange {
                    endRangeState = .typing
                    endRangeAnnounceState = .endAlert
                    isEndRangeValid = true
                } else {
                    endRangeState = .alert
                    endRangeAnnounceState = .endAlert
                    isEndRangeValid = false
                }
            }
        } else if newText.isEmpty {
            endRangeState = .defaultState
            endRangeAnnounceState = .startAlert
            isEndRangeValid = false
        }
    }
    
    func handleStartRangeFocusChange(
        newText: String,
        isStartRangeFocused: Bool
    ) {
        if !isStartRangeFocused {
            if newText == "0" || newText == "00" || newText == "000" || newText == "0000" {
                startRangeState = .alert
                startRangeAnnounceState = .zero
                isStartRangeValid = false
                return
            }
            
            let trimmedText = newText.trimmingLeadingZeros()
            if !trimmedText.hasSuffix("p") && !trimmedText.isEmpty {
                startRangeString = trimmedText + "p"
            } else {
                startRangeString = trimmedText
            }
            
            if newText.isEmpty {
                startRangeState = .defaultState
                isStartRangeValid = false
            } else if newText.isValidStudyRange {
                startRange = Int(startRangeString.dropLast()) ?? 0
                startRangeState = .field
                startRangeAnnounceState = .startAlert
                isStartRangeValid = true
                
                if endRange < startRange && endRange != 0 {
                    endRangeState = .alert
                    endRangeAnnounceState = .rangeFlippedWrong
                    isEndRangeValid = false
                } else {
                    if endRangeString.isEmpty {
                        endRangeState = .defaultState
                        endRangeAnnounceState = .endAlert
                        isEndRangeValid = false
                    } else {
                        endRangeState = .field
                        endRangeAnnounceState = .endAlert
                        isEndRangeValid = true
                    }
                }
            } else {
                startRangeState = .alert
                startRangeAnnounceState = .startAlert
                isStartRangeValid = false
            }
        } else {
            if newText.hasSuffix("p") {
                startRangeString = String(newText.dropLast())
            }
            
            startRangeState = .placeholder
            isStartRangeValid = false
        }
    }
    
    func handleEndRangeFocusChange(
        newText: String,
        isEndRangeFocused: Bool
    ) {
        if !isEndRangeFocused {
            if newText == "0" || newText == "00" || newText == "000" || newText == "0000" {
                endRangeState = .alert
                endRangeAnnounceState = .zero
                isEndRangeValid = false
                return
            }
            
            let trimmedText = newText.trimmingLeadingZeros()
            if !trimmedText.hasSuffix("p") && !trimmedText.isEmpty {
                endRangeString = trimmedText + "p"
            } else {
                endRangeString = trimmedText
            }
            
            if newText.isEmpty {
                endRangeState = .defaultState
                isEndRangeValid = false
            } else if newText.isValidStudyRange {
                endRange = Int(endRangeString.dropLast()) ?? 0
                
                if endRange < startRange && startRange != 0 {
                    endRangeState = .alert
                    endRangeAnnounceState = .rangeFlippedWrong
                    isEndRangeValid = false
                } else {
                    endRangeState = .field
                    endRangeAnnounceState = .endAlert
                    isEndRangeValid = true
                }
            } else {
                endRangeState = .alert
                endRangeAnnounceState = .endAlert
                isEndRangeValid = false
            }
        } else {
            if newText.hasSuffix("p") {
                endRangeString = String(newText.dropLast())
            }
            
            endRangeState = .placeholder
            isEndRangeValid = false
        }
    }
}
