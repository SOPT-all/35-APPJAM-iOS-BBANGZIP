//
//  SubjectDetailViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class SubjectDetailViewModel: ObservableObject {
    @Published var modelList: [StudyPieceModel]
    @Published var isDeleteMode: Bool = false
    @Published var isDeleteButtonEnable: Bool = false
    @Published var isShowingBottomSheet: Bool = false
    
    var selectedItemCount: Int {
        modelList.filter { $0.state == .selected }.count
    }
    
    init(modelList: [StudyPieceModel]) {
        self.modelList = modelList
    }
    
    func makeStudyPieceSelectable() {
        isDeleteMode.toggle()
        modelList = modelList.map(
            {
                StudyPieceModel(
                    pieceID: $0.pieceID,
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
