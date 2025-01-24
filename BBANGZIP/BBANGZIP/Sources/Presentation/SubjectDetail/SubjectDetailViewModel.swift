//
//  SubjectDetailViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class SubjectDetailViewModel: ObservableObject {
    private let filterExamUseCase: FilterExamUseCase
    private let deleteStudyPieceUseCase: DeleteStudyPieceUseCase
    
    let subjectName: String
    let subjectId: Int
    @Published var selectedPieceIds: Set<Int> = []
    @Published var currentExam: String = "중간고사"
    @Published var motivationMessage: String = ""
    @Published var modelList: [FilterExamList] = []
    @Published var isDeleteMode: Bool = false
    @Published var isLoading: Bool = true
    @Published var isDeleteButtonEnable: Bool = false
    @Published var isShowingBottomSheet: Bool = false
    @Published var toast: Toast?
    
    var selectedItemCount: Int {
        return selectedPieceIds.count
    }
    
    init(
        filterExamUseCase: FilterExamUseCase,
        deleteStudyPieceUseCase: DeleteStudyPieceUseCase,
        subjectName: String = "",
        subjectId: Int
    ) {
        self.filterExamUseCase = filterExamUseCase
        self.deleteStudyPieceUseCase = deleteStudyPieceUseCase
        self.subjectName = subjectName
        self.subjectId = subjectId
    }
    
    func toggleSelection(pieceId: Int) {
        if selectedPieceIds.contains(pieceId) {
            selectedPieceIds.remove(pieceId)
        } else {
            selectedPieceIds.insert(pieceId)
        }
    }
    
    func convertExamNameToAPI(_ examName: String) -> String {
        switch examName {
        case "중간고사":
            return "mid"
        case "기말고사":
            return "fin"
        default:
            return "mid"
        }
    }
    
    func makeStudyPieceSelectable() {
        isDeleteMode.toggle()
        selectedPieceIds.removeAll()
        modelList = modelList.map {
            FilterExamList(
                pieceId: $0.pieceId,
                studyContents: $0.studyContents,
                startPage: $0.startPage,
                finishPage: $0.finishPage,
                deadline: $0.deadline,
                remainingDays: $0.remainingDays,
                isFinished: $0.isFinished,
                state: $0.state == .complete ? .complete : ($0.state == .cardDefault ? .selectable : .cardDefault)
            )
        }
    }
    
    @MainActor
    func fetchData() async {
        do {
            let examContent = try await filterExamUseCase.execute(
                subjectId: subjectId,
                examName: convertExamNameToAPI(currentExam)
            )
            modelList = examContent.studyList
            motivationMessage = examContent.motivationMessage
            isLoading = false
        } catch {
            dump(error)
            print(error)
            isLoading = false
        }
    }
    
    @MainActor
    func updateExam(_ examName: String) async {
        currentExam = examName
        await fetchData()
    }
    
    @MainActor
    func deleteStudyPiece() async {
        do {
            let _: () = try await deleteStudyPieceUseCase.execute(
                pieceIds: Array(selectedPieceIds)
            )
            
            // 삭제 후 데이터 새로고침
            await fetchData()
            
            // 상태 초기화
            selectedPieceIds.removeAll()
            isDeleteMode = false
            
            // 토스트 메시지 표시
            toast = Toast(
                "공부 삭제 완료",
                startFrom: 20
            )
        } catch {
            dump(error)
            print(error)
        }
    }
    
    func validateDeleteButton() {
        isDeleteButtonEnable = !selectedPieceIds.isEmpty
    }
    
    func completeStudyPiece() {
        // TODO: 공부 조각 완료하기 API 연동 필요
    }
    
    func notCompleteStudyPiece() {
        // TODO: 공부 조각 미완료 체크하기 API 연동 필요
    }
    
    func checkCompleteOrNot() {
        isShowingBottomSheet = true
    }
    
    func resetSelectedState() {
        // TODO: 완료 해제 로직 필요
        isShowingBottomSheet = false
    }
}
