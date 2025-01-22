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
    
    @Published var isLoading: Bool = true
    
    @Published var revertTargetPieceID: Int? = nil
    @Published var isDeleteMode: Bool = false
    @Published var isDeleteButtonEnable: Bool = false
    @Published var toast: Toast?
    @Published var isRevertBottomSheetPresent: Bool = false
    @Published var isFilterBottomSheetPresent: Bool = false
    @Published var sortOption: FetchTodayStudySortOption = .recent
    @Published var badges: [Badge] = []
    
    @Published var todayCount: Int = 0
    @Published var completeCount: Int = 0
    @Published var pendingCount: Int = 0
    @Published var todoPiecesList: [StudyPiece] = []
    @Published var completeAnnounceText: String = ""
    @Published var todayAnnounceText: String = ""
    
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
            reloadCompleteAnnounceText()
            reloadTodayAnnounceText()
            
            isLoading = false
        } catch {
            dump(error)
            print(error)
            todayCount = 1
            completeCount = 1
            pendingCount = 1
            todoPiecesList = StudyPiece.mockList
            completeAnnounceText = "사장님 퇴근 준비 완료"
            todayAnnounceText = "오늘의 공부를 모두 끝냈어요!"
            
            isLoading = false
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
            badges.append(contentsOf: complteResult)
            todayCount -= 1
            completeCount += 1
            toast = Toast(
                "공부 완료! 오늘의 빵 굽기 성공!",
                startFrom: 76
            )
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
            
            todayCount += 1
            completeCount -= 1
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
            isDeleteMode = false
        } catch {
            dump(error)
            print(error)
        }
    }
    
    func reloadCompleteAnnounceText() {
        if todayCount > 0 {
            if completeCount > 0 {
                completeAnnounceText = "벌써 \(completeCount)개나 완료하셨네요!"
            } else {
                completeAnnounceText = "아직 완료된 할일이 없어요!"
            }
        } else {
            completeAnnounceText = "사장님 퇴근 준비 완료"
        }
    }
    
    func reloadTodayAnnounceText() {
        if todayCount > 0 {
            todayAnnounceText = "총 \(todayCount)개의 공부가 남았어요"
        } else {
            todayAnnounceText = "오늘의 공부를 모두 끝냈어요!"
        }
    }
}
