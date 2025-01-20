//
//  StudyManageViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class SubjectManageViewModel: ObservableObject {
    @Published var isShowingBottomSheet: Bool
    @Published var modelList: [SubjectCardModel]
    
    init(
        isShowingBottomSheet: Bool = false,
        modelList: [SubjectCardModel]
    ) {
        self.isShowingBottomSheet = isShowingBottomSheet
        self.modelList = modelList
    }
    
    func showChangeSemesterSheet() {
        isShowingBottomSheet = true
    }
    
    func deleteSubject() {
        let currentState: CardState = modelList.first?.state ?? SubjectCardState.cardDefault
        
        let newState: CardState = switch currentState {
        case SubjectCardState.cardDefault:
            SubjectCardState.selectable
        case SubjectCardState.selectable:
            SubjectCardState.cardDefault
        default:
            currentState
        }
        
        for i in modelList.indices {
            modelList[i].state = newState
        }
    }
    
    func getState(for id: Int) -> CardState {
        
        return modelList[id].state
    }
    
    func selectSubject(id: Int) {
        let currentState = getState(for: id)
        
        switch currentState {
        case SubjectCardState.selectable:
            modelList[id].state = SubjectCardState.selected
        case SubjectCardState.selected:
            modelList[id].state = SubjectCardState.selectable
        default:
            break
        }
    }
    
    func fetchSubjectData() {
        modelList = SubjectCardModel.mockList
    }
}
