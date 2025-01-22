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
    private let completeTodayStudyUseCase: CompleteTodayStudyUseCase
    private let revertCompleteTodayStudyUseCase: RevertCompleteTodayStudyUseCase
    private let removeTodayStudyUseCase: RemoveTodayStudyUseCase
    
//    @Published var isBottomSheetShowing: Bool = false
    @Published var revertTargetPieceID: Int? = nil
    
    @Published var isDeleteMode: Bool = false
    @Published var isDeleteButtonEnable: Bool = false
    @Published var toast: Toast?
    @Published var isRevertBottomSheetPresent: Bool = false
    @Published var isFilterBottomSheetPresent: Bool = false
    @Published var sortOption: FetchTodayStudySortOption = .recent
    
    @Published var todayCount: Int = 0
    @Published var completeCount: Int = 0
    @Published var pendingCount: Int = 0
    @Published var todoPiecesList: [StudyPiece] = []
    @Published var completeAnnounceText: String = ""
    @Published var pendingAnnounceText: String = ""
    
    init(
        fetchTodayStudyUseCase: FetchTodayStudyUseCase,
        completeTodayStudyUseCase: CompleteTodayStudyUseCase,
        revertCompleteTodayStudyUseCase: RevertCompleteTodayStudyUseCase,
        removeTodayStudyUseCase: RemoveTodayStudyUseCase
    ) {
        self.fetchTodayStudyUseCase = fetchTodayStudyUseCase
        self.completeTodayStudyUseCase = completeTodayStudyUseCase
        self.revertCompleteTodayStudyUseCase = revertCompleteTodayStudyUseCase
        self.removeTodayStudyUseCase = removeTodayStudyUseCase
    }
    
    @MainActor
    func fetchData() async {
        do {
            let todayStudyContent = try await fetchTodayStudyUseCase.execute(
                area: .todo,
                year: 2025, // TODO: 스프린트에서 변경 예정
                semester: .first, // TODO: 스프린트에서 변경 예정
                sortOption: sortOption
            )
            todayCount = todayStudyContent.todayCount
            completeCount = todayStudyContent.completeCount
            pendingCount = todayStudyContent.pendingCount
            todoPiecesList = todayStudyContent.todoPiecesList
            completeAnnounceText = todayStudyContent.completeAnnounceText
            pendingAnnounceText = todayStudyContent.pendingAnnounceText
        } catch {
            dump(error)
            print(error)
            todayCount = 1
            completeCount = 1
            pendingCount = 1
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
    
    @MainActor
    func completeStudy(pieceID: Int) async {
        do {
            let complteResult = try await completeTodayStudyUseCase.execute(pieceID: pieceID)
        } catch {
            dump(error)
            print(error)
        }
    }
    
    @MainActor
    func revertCompleteStudy() async {
        guard let revertTargetPieceID = revertTargetPieceID else {
            print("revertTargetPieceID Wrong")
            return
        }
        do {
            try await revertCompleteTodayStudyUseCase.execute(pieceID: revertTargetPieceID)
            guard let revertedPieceIndex = todoPiecesList.firstIndex(where: {$0.id == revertTargetPieceID}) else {
                print("서버에서는 revert 됐는데 list에서 못 찾는 경우")
                return
                
            }
            todoPiecesList[revertedPieceIndex] = StudyPiece(
                id: todoPiecesList[revertedPieceIndex].id,
                subjectName: todoPiecesList[revertedPieceIndex].subjectName,
                examName: todoPiecesList[revertedPieceIndex].examName,
                studyContents: todoPiecesList[revertedPieceIndex].studyContents,
                startPage: todoPiecesList[revertedPieceIndex].startPage,
                finishPage: todoPiecesList[revertedPieceIndex].finishPage,
                deadline: todoPiecesList[revertedPieceIndex].deadline,
                remainingDays: todoPiecesList[revertedPieceIndex].remainingDays,
                isFinished: todoPiecesList[revertedPieceIndex].isFinished,
                state: .cardDefault
            )
        } catch {
            dump(error)
            print(error)
        }
    }
    
    @MainActor
    func removeTodayStudyPieces() async {
        let pieceIDs = todoPiecesList
            .compactMap { $0.state == .selected ? $0.id : nil }
        do {
            try await removeTodayStudyUseCase.execute(pieceIDs: pieceIDs)
            await fetchData()
        } catch {
            dump(error)
            print(error)
        }
    }
}
