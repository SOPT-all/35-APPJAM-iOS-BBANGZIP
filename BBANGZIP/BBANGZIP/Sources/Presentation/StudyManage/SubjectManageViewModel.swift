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
    @Published var state: CardState
    
    init(
        isShowingBottomSheet: Bool = false,
        state: CardState = SubjectCardState.cardDefault
    ) {
        self.isShowingBottomSheet = isShowingBottomSheet
        self.state = state
    }
    
    func showChangeSemesterSheet() {
        isShowingBottomSheet = true
    }
    
    func deleteSubject() {
        switch state {
        case SubjectCardState.cardDefault:
            state = SubjectCardState.selectable
        case SubjectCardState.selectable:
            state = SubjectCardState.cardDefault
        default:
            break
        }
    }
}
