//
//  AddStudyViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class AddStudyViewModel: ObservableObject {
    @Published var date: Date?
    @Published var studyContent: String
    @Published var startRange: Int?
    @Published var endRange: Int?
    @Published var startRangeString: String
    @Published var endRangeString: String
    @Published var dateState: TextFieldState
    @Published var contentState: TextFieldState
    @Published var contentAnnounceState: StudyContentTextFieldAlertCase?
    @Published var startRangeState: TextFieldState
    @Published var startRangeAnnounceState: StudyRangeTextFieldAlertCase?
    @Published var endRangeState: TextFieldState
    @Published var endRangeAnnounceState: StudyRangeTextFieldAlertCase?
    
    var formattedDate: String {
        guard let date = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter.string(from: date)
    }
    
    init(
        date: Date? = nil,
        studyContent: String = "",
        startRange: Int? = nil,
        endRange: Int? = nil,
        dateState: TextFieldState = .defaultState,
        contentState: TextFieldState = .defaultState,
        contentAnnounceState: StudyContentTextFieldAlertCase? = .defaultCorrect,
        startRangeState: TextFieldState = .defaultState,
        startRangeAnnounceState: StudyRangeTextFieldAlertCase? = .startDefaultCorrect,
        endRangeState: TextFieldState = .defaultState,
        endRangeAnnounceState: StudyRangeTextFieldAlertCase? = .endDefaultCorrect
    ) {
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
    }
    
    // TODO: 텍스트필드 입력 시 상태 변화하는 로직 추가 필요
    // TODO: 텍스트필드 입력값에 따라 버튼 활성화하는 로직 추가 필요
    // TODO: 학습 범위에는 정수만 입력하도록 제한하는 로직 추가 필요
}
