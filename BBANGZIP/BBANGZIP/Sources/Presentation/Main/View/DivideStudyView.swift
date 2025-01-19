//
//  DivideStudyView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct DivideStudyView: View {
    @State private var isBottomSheetPresented = true
    @State private var selectedBottomSheetType: BottomSheetType? = .divideStudy
    
    var body: some View {
        VStack {
            Button("공부 내용 등록하기") {
                selectedBottomSheetType = .divideStudy
                isBottomSheetPresented = true
            }
        }
        .bottomSheet(
            isShowing: $isBottomSheetPresented,
            height: 449) {
                if let type = selectedBottomSheetType {
                    type.contentView(isPresented: $isBottomSheetPresented)
                }
            }
    }
}

#Preview {
    DivideStudyView()
}

