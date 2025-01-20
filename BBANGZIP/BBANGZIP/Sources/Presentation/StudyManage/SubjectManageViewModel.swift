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
    @Published private(set) var state: [Int: CardState]
    
    init(
        isShowingBottomSheet: Bool = false,
        initialState: CardState = SubjectCardState.cardDefault,
        // TODO: dataCount 추후 API 연동 후 수정 필요
        dataCount: Int
    ) {
        self.isShowingBottomSheet = isShowingBottomSheet
        var initialStates: [Int: CardState] = [:]
        for id in 1...dataCount {
            initialStates[id] = SubjectCardState.cardDefault
        }
        self.state = initialStates
    }
    
    func showChangeSemesterSheet() {
        isShowingBottomSheet = true
    }
    
    func deleteSubject() {
        let currentState = state.values.first ?? SubjectCardState.cardDefault
        
        let newState: CardState = switch currentState {
        case SubjectCardState.cardDefault:
            SubjectCardState.selectable
        case SubjectCardState.selectable:
            SubjectCardState.cardDefault
        default:
            currentState
        }
        
        for key in state.keys {
            state[key] = newState
        }
    }
    
    func getState(for id: Int) -> CardState {
        
        return state[id] ?? SubjectCardState.cardDefault
    }
    
    func selectSubject(id: Int) {
        let currentState = getState(for: id)
        
        switch currentState {
        case SubjectCardState.selectable:
            state[id] = SubjectCardState.selected
        case SubjectCardState.selected:
            state[id] = SubjectCardState.selectable
        default:
            break
        }
    }
}
