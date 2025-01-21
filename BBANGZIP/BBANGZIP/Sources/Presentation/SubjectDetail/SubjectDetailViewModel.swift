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
    
    init(modelList: [StudyPieceModel] = []) {
        self.modelList = modelList
    }
    
    func deleteStudyPiece() {
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
    
    func validateDeleteButton() {
        isDeleteButtonEnable = modelList.count(where: { $0.state == .selected }) > 0
    }
}
