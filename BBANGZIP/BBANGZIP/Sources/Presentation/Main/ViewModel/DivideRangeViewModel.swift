//
//  DivideRangeViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class DivideRangeViewModel: ObservableObject {
    @Published var startRange: Int = 0
    @Published var endRange: Int = 0
    @Published var startRangeStrings: [String]
    @Published var endRangeStrings: [String]
    @Published var startRangeStates: [TextFieldState]
    @Published var endRangeStates: [TextFieldState]
    @Published var startRangeAnnounceStates: [StudyRangeTextFieldAlertCase?]
    @Published var endRangeAnnounceStates: [StudyRangeTextFieldAlertCase?]
    @Published var isStartRangeValid: [Bool]
    @Published var isEndRangeValid: [Bool]
    @Published var isDatePickerPresented = false
    @Published var date: Date?
    @Published var deadlineDates: [String]
    @Published var pieces: [Int]
    
    @Published var selectedYear: Int = 2025
    @Published var selectedMonth: Int = 1
    @Published var selectedDay: Int = 1
    @Published var isButtonTapped: Bool = false
    
    init(
        pieceCount: Int,
        startPage: Int,
        endPage: Int,
        totalDays: Int
    ) {
        self.date = nil
        self.startRangeStrings = Array(repeating: "", count: pieceCount)
        self.endRangeStrings = Array(repeating: "", count: pieceCount)
        self.startRangeStates = Array(repeating: .defaultState, count: pieceCount)
        self.endRangeStates = Array(repeating: .defaultState, count: pieceCount)
        self.startRangeAnnounceStates = Array(repeating: .startAlert, count: pieceCount)
        self.endRangeAnnounceStates = Array(repeating: .endAlert, count: pieceCount)
        self.isStartRangeValid = Array(repeating: false, count: pieceCount)
        self.isEndRangeValid = Array(repeating: false, count: pieceCount)
        self.pieces = Array(1...pieceCount)
        self.deadlineDates = Array(repeating: "", count: pieceCount)
        self.selectedYear = selectedYear
        self.selectedMonth = selectedMonth
        self.selectedDay = selectedDay
        self.isButtonTapped = isButtonTapped
        
        setupRanges(
            startPage: startPage,
            endPage: endPage,
            pieceCount: pieceCount
        )
        setupDates(
            startDate: Date(),
            totalDays: totalDays,
            pieceCount: pieceCount
        )
    }
    
    func setupRanges(
        startPage: Int,
        endPage: Int,
        pieceCount: Int
    ) {
        let totalPages = endPage - startPage + 1
        let pagesPerPiece = totalPages / pieceCount
        var currentStart = startPage
        
        for i in 0..<pieceCount {
            var currentEnd = currentStart + pagesPerPiece
            
            if i == pieceCount - 1 {
                currentEnd = endPage
                self.endRange = currentEnd
            } else if i == 0 {
                self.startRange = currentStart
            }
            
            startRangeStrings[i] = "\(currentStart)p"
            endRangeStrings[i] = "\(currentEnd)p"
            
            currentStart = currentEnd
        }
    }
    
    private func setupDates(
        startDate: Date,
        totalDays: Int,
        pieceCount: Int
    ) {
        let actualStartDate = Calendar.current.date(
            byAdding: .day,
            value: 2,
            to: startDate
        ) ?? Date()
        let daysPerPiece = totalDays / pieceCount
        var currentStartDate = actualStartDate
        let remainder = totalDays % pieceCount
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        
        for i in 0..<pieceCount {
            var currentEndDate = Calendar.current.date(
                byAdding: .day,
                value: daysPerPiece - 1 + (i == pieceCount - 1 ? remainder : 0),
                to: currentStartDate
            ) ?? Date()
            
            let endDateString = formatter.string(from: currentEndDate)
            
            deadlineDates[i] = "\(endDateString) 까지"
            currentStartDate = Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: currentEndDate
            ) ?? Date()
        }
    }
    
    func verifyStartRange(
        for index: Int,
        newText: String,
        isStartRangeFocused: Bool
    ) {
        if isStartRangeFocused {
            startRangeStates[index] = .typing
            
            if newText.isEmpty {
                startRangeStates[index] = .defaultState
                startRangeAnnounceStates[index] = .startAlert
                isStartRangeValid[index] = false
            } else {
                if newText.isValidStudyRange {
                    startRangeStates[index] = .typing
                    startRangeAnnounceStates[index] = .startAlert
                    isStartRangeValid[index] = true
                } else {
                    startRangeStates[index] = .alert
                    startRangeAnnounceStates[index] = .startAlert
                    isStartRangeValid[index] = false
                }
            }
        } else if newText.isEmpty {
            startRangeStates[index] = .defaultState
            startRangeAnnounceStates[index] = .startAlert
            isStartRangeValid[index] = false
        }
    }
    
    func handleStartRangeFocusChange(
        for index: Int,
        newText: String,
        isStartRangeFocused: Bool
    ) {
        if !isStartRangeFocused {
            if newText == "0" || newText == "00" || newText == "000" || newText == "0000" {
                startRangeStates[index] = .alert
                startRangeAnnounceStates[index] = .zero
                isStartRangeValid[index] = false
                return
            }
            
            let trimmedText = newText.trimmingLeadingZeros()
            if !trimmedText.hasSuffix("p") && !trimmedText.isEmpty {
                startRangeStrings[index] = trimmedText + "p"
            } else {
                startRangeStrings[index] = trimmedText
            }
            
            if newText.isEmpty {
                startRangeStates[index] = .defaultState
                isStartRangeValid[index] = false
            } else if newText.isValidStudyRange {
                startRange = Int(startRangeStrings[index].dropLast()) ?? 0
                startRangeStates[index] = .field
                startRangeAnnounceStates[index] = .startAlert
                isStartRangeValid[index] = true
                
                if endRange < startRange && endRange != 0 {
                    endRangeStates[index] = .alert
                    endRangeAnnounceStates[index] = .rangeFlippedWrong
                    isEndRangeValid[index] = false
                } else {
                    if endRangeStrings[index].isEmpty {
                        endRangeStates[index] = .defaultState
                        endRangeAnnounceStates[index] = .endAlert
                        isEndRangeValid[index] = false
                    } else {
                        endRangeStates[index] = .field
                        endRangeAnnounceStates[index] = .endAlert
                        isEndRangeValid[index] = true
                    }
                }
            } else {
                startRangeStates[index] = .alert
                startRangeAnnounceStates[index] = .startAlert
                isStartRangeValid[index] = false
            }
        } else {
            if newText.hasSuffix("p") {
                startRangeStrings[index] = String(newText.dropLast())
            }
            
            startRangeStates[index] = .placeholder
            isStartRangeValid[index] = false
        }
    }
    
    func verifyEndRange(
        for index: Int,
        newText: String,
        isEndRangeFocused: Bool
    ) {
        if isEndRangeFocused {
            endRangeStates[index] = .typing
            
            if newText.isEmpty {
                endRangeStates[index] = .defaultState
                endRangeAnnounceStates[index] = .endAlert
                isEndRangeValid[index] = false
            } else {
                if newText.isValidStudyRange {
                    endRangeStates[index] = .typing
                    endRangeAnnounceStates[index] = .endAlert
                    isEndRangeValid[index] = true
                } else {
                    endRangeStates[index] = .alert
                    endRangeAnnounceStates[index] = .endAlert
                    isEndRangeValid[index] = false
                }
            }
        } else if newText.isEmpty {
            endRangeStates[index] = .defaultState
            endRangeAnnounceStates[index] = .startAlert
            isEndRangeValid[index] = false
        }
    }
    
    func handleEndRangeFocusChange(
        for index: Int,
        newText: String,
        isEndRangeFocused: Bool
    ) {
        if !isEndRangeFocused {
            if newText == "0" || newText == "00" || newText == "000" || newText == "0000" {
                endRangeStates[index] = .alert
                endRangeAnnounceStates[index] = .zero
                isEndRangeValid[index] = false
                return
            }
            
            let trimmedText = newText.trimmingLeadingZeros()
            if !trimmedText.hasSuffix("p") && !trimmedText.isEmpty {
                endRangeStrings[index] = trimmedText + "p"
            } else {
                endRangeStrings[index] = trimmedText
            }
            
            if newText.isEmpty {
                endRangeStates[index] = .defaultState
                isEndRangeValid[index] = false
            } else if newText.isValidStudyRange {
                endRange = Int(endRangeStrings[index].dropLast()) ?? 0
                
                if endRange < startRange && startRange != 0 {
                    endRangeStates[index] = .alert
                    endRangeAnnounceStates[index] = .rangeFlippedWrong
                    isEndRangeValid[index] = false
                } else {
                    endRangeStates[index] = .field
                    endRangeAnnounceStates[index] = .endAlert
                    isEndRangeValid[index] = true
                }
            } else {
                endRangeStates[index] = .alert
                endRangeAnnounceStates[index] = .endAlert
                isEndRangeValid[index] = false
            }
        } else {
            if newText.hasSuffix("p") {
                endRangeStrings[index] = String(newText.dropLast())
            }
            
            endRangeStates[index] = .placeholder
            isEndRangeValid[index] = false
        }
    }
}
