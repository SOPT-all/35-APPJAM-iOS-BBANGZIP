//
//  DivideRangeViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class DivideRangeViewModel: ObservableObject {
    @Published var date: Date?
    @Published var startRange: Int = 0
    @Published var endRange: Int = 0
    @Published var startRangeString: String
    @Published var endRangeString: String
    
    @Published var startRangeState: TextFieldState
    @Published var startRangeAnnounceState: StudyRangeTextFieldAlertCase?
    @Published var endRangeState: TextFieldState
    @Published var endRangeAnnounceState: StudyRangeTextFieldAlertCase?
    @Published var isStartRangeValid: Bool = false
    @Published var isEndRangeValid: Bool = false
    
    @Published var isDatePickerPresented = false
        
    var formattedDate: String {
        guard let date = date else { return "" }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: date)
    }
    
    init(
        date: Date? = nil,
        startRange: Int = 0,
        endRange: Int = 0,
        startRangeState: TextFieldState = .defaultState,
        startRangeAnnounceState: StudyRangeTextFieldAlertCase? = .startAlert,
        endRangeState: TextFieldState = .defaultState,
        endRangeAnnounceState: StudyRangeTextFieldAlertCase? = .endAlert
    ) {
        self.date = date
        self.startRange = startRange
        self.endRange = endRange
        self.startRangeString = ""
        self.endRangeString = ""
        self.startRangeState = startRangeState
        self.startRangeAnnounceState = startRangeAnnounceState
        self.endRangeState = endRangeState
        self.endRangeAnnounceState = endRangeAnnounceState
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
