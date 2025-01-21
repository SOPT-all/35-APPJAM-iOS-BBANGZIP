//
//  SubjectDetailViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class SubjectDetailViewModel: ObservableObject {
    @Published var modelList: [StudyCardModel]
    
    init(modelList: [StudyCardModel]) {
        self.modelList = modelList
    }
    
    func deleteStudyPiece() {
        let currentState: StudyCardState = modelList.first?.studyList.first?.state ?? .cardDefault
        
        let newState: StudyCardState = switch currentState {
        case .cardDefault:
            .selectable
        case .selectable:
            .cardDefault
        default:
            currentState
        }
    }
}
