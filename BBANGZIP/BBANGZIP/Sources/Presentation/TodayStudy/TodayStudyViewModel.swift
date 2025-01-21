//
//  TodayStudyViewModel.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class TodayStudyViewModel: ObservableObject {
    private let fetchTodayStudyUseCase: FetchTodayStudyUseCase
    @Published var isDeleteMode: Bool = false
    @Published var isDeleteButtonEnable: Bool = false
    
    @Published var todayCount: Int = 0
    @Published var completeCount: Int = 0
    @Published var pendingCount: Int = 0
    @Published var todoPiecesList: [StudyPiece] = []
    @Published var completeAnnounceText: String = ""
    @Published var pendingAnnounceText: String = ""
    
    init(fetchTodayStudyUseCase: FetchTodayStudyUseCase) {
        self.fetchTodayStudyUseCase = fetchTodayStudyUseCase
    }
    
    @MainActor
    func fetchData() async {
        do {
            let todayStudyContent = try await fetchTodayStudyUseCase.execute(
                area: .todo,
                year: 2025, // TODO: 스프린트에서 변경 예정
                semester: .first, // TODO: 스프린트에서 변경 예정
                sortOption: .recent
            )
            todayCount = todayStudyContent.todayCount
            completeCount = todayStudyContent.completeCount
            pendingCount = todayStudyContent.pendingCount
            todoPiecesList = todayStudyContent.todoPiecesList
            completeAnnounceText = todayStudyContent.completeAnnounceText
            pendingAnnounceText = todayStudyContent.pendingAnnounceText
        } catch {
            dump(error)
            todayCount = 1
            completeCount = 0
            pendingCount = 0
            todoPiecesList = StudyPiece.mockList
            completeAnnounceText = "사장님 퇴근 준비 완료"
            pendingAnnounceText = "오늘의 공부를 모두 끝냈어요!"
        }
    }
    
    func trashButtonTapped() {
        isDeleteMode.toggle()
        todoPiecesList = todoPiecesList.map(
            {
                StudyPiece(
                    id: $0.id,
                    subjectName: $0.subjectName,
                    examName: $0.examName,
                    studyContents: $0.studyContents,
                    startPage: $0.startPage,
                    finishPage: $0.finishPage,
                    deadline: $0.deadline,
                    remainingDays: $0.remainingDays,
                    isFinished: $0.isFinished,
                    state: $0.state == .complete ? .complete : ($0.state == .cardDefault ? .selectable : .cardDefault)
                )
            }
        )
        validateDeleteButton()
    }
    
    func validateDeleteButton() {
        isDeleteButtonEnable = todoPiecesList.count(where: { $0.state == .selected }) > 0
    }
}
