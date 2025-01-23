//
//  StudyManageViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class SubjectManageViewModel: ObservableObject {
    private let fetchSubjectUseCase: FetchSubjectUseCase
    
    @Published var isShowingBottomSheet: Bool = false
    @Published var isLoading: Bool = true
    @Published var isDeleteMode: Bool = false
    @Published var isDeleteButtonEnable: Bool = false
    
    @Published var modelList: [SubjectCardModel] = []
    
    var selectedItemCount: Int {
        modelList.filter { $0.state == .selected }.count
    }
    
    init(
        fetchSubjectUseCase: FetchSubjectUseCase
    ) {
        self.fetchSubjectUseCase = fetchSubjectUseCase
    }
    
    @MainActor
    func fetchData() async {
        do {
            let subjectContent = try await fetchSubjectUseCase.execute(
                year: 2025, // TODO: 스프린트 변경 예정
                semester: .first // TODO: 스프린트 변경 예정
            )
            modelList = subjectContent.SubjectList
            
            isLoading = false
        } catch {
            dump(error)
            print(error)
        }
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
