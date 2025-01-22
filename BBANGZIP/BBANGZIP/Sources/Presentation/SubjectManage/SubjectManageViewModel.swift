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
    @Published var isDeleteMode: Bool = false
    @Published var isDeleteButtonEnable: Bool = false
    @Published var modelList: [SubjectCardModel]
    
    var selectedItemCount: Int {
        modelList.filter { $0.state == .selected }.count
    }
    
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
    
    func makeDeleteMode() {
        isDeleteMode.toggle()
    }
    
    func makeSelectableSubject() {
        isDeleteMode.toggle()
        modelList = modelList.map {
            var updatedModel = $0
            updatedModel.state = $0.state == .cardDefault ? .selectable : .cardDefault
            return updatedModel
        }
    }
    
    func validateDeleteButton() {
        isDeleteButtonEnable = modelList.count(where: { $0.state == .selected }) > 0
    }
    
    func deleteStudy() {
        
    }
    
    func fetchSubjectData() {
        modelList = SubjectCardModel.mockList
    }
}
