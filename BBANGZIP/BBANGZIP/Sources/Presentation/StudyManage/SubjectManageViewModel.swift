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
    
    init(isShowingBottomSheet: Bool = false) {
        self.isShowingBottomSheet = isShowingBottomSheet
    }
    
    func showChangeSemesterSheet() {
        isShowingBottomSheet = true
    }
    
    private func deleteSubject() {
        // TODO: 과목 삭제 로직 구현
    }
}
