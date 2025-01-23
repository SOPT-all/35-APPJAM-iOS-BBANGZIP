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
    
    let subjectName: String
    private let subjectId: Int
    @Published var currentExam: String = "중간고사"
    @Published var motivationMessage: String = ""
    @Published var modelList: [FilterExamList] = []
    @Published var isDeleteMode: Bool = false
    @Published var isLoading: Bool = true
    @Published var isDeleteButtonEnable: Bool = false
    @Published var isShowingBottomSheet: Bool = false
    
    var selectedItemCount: Int {
        modelList.filter { $0.state == .selected }.count
    }
    
    init(
        filterExamUseCase: FilterExamUseCase,
        subjectName: String = "",
        subjectId: Int
    ) {
        self.filterExamUseCase = filterExamUseCase
        self.subjectName = subjectName
        self.subjectId = subjectId
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
        modelList = modelList.map(
            {
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
        )
    }
    
    @MainActor
    func fetchData() async {
        do {
            let examContent = try await filterExamUseCase.execute(
                subjectId: subjectId, // TODO: 스프린트 변경 예정
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
    
    func deleteStudyPiece() {
        // TODO: 공부 삭제 API 연동 및 삭제 성공 시 토스트 메시지 노출
    }
    
    func validateDeleteButton() {
        isDeleteButtonEnable = modelList.count(where: { $0.state == .selected }) > 0
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
