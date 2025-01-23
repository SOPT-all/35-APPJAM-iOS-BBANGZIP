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
    private let deleteSubjectUseCase: DeleteSubjectUseCase
    
    @Published var selectedSubjectIds: Set<Int> = []
    @Published var isShowingBottomSheet: Bool = false
    @Published var isLoading: Bool = true
    @Published var isDeleteMode: Bool = false
    @Published var isDeleteButtonEnable: Bool = false
    @Published var toast: Toast?
    
    @Published var modelList: [SubjectCardModel] = []
    
    init(
        fetchSubjectUseCase: FetchSubjectUseCase,
        deleteSubjectUseCase: DeleteSubjectUseCase
    ) {
        self.fetchSubjectUseCase = fetchSubjectUseCase
        self.deleteSubjectUseCase = deleteSubjectUseCase
    }
    
    var selectedItemCount: Int {
        return selectedSubjectIds.count
    }
    
    func toggleSelection(subjectId: Int) {
        if selectedSubjectIds.contains(subjectId) {
            selectedSubjectIds.remove(subjectId)
        } else {
            selectedSubjectIds.insert(subjectId)
        }
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
    
    @MainActor
    func deleteSubject() async {
        
        do {
            let _: () = try await deleteSubjectUseCase.execute(
                year: 2025,
                semester: .first,
                subjectIds: Array(selectedSubjectIds)
            )
            
            await fetchData()
            
            selectedSubjectIds.removeAll()
            
            isDeleteMode = false
            
            toast = Toast(
                "과목 삭제 완료",
                startFrom: 16
            )
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
        selectedSubjectIds.removeAll()
        modelList = modelList.map {
            var updatedModel = $0
            updatedModel.state = $0.state == .cardDefault ? .selectable : .cardDefault
            return updatedModel
        }
    }
    
    func validateDeleteButton() {
        isDeleteButtonEnable = !selectedSubjectIds.isEmpty
    }
    
    func fetchSubjectData() {
        modelList = SubjectCardModel.mockList
    }
}
