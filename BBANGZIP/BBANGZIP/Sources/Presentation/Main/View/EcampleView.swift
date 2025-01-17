//
//  ExampleView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ExampleView: View {
    @State private var isBottomSheetPresented = true
    @State private var selectedBottomSheetType: BottomSheetType? = .examDate
    
    var body: some View {
        VStack {
            Button("시험 날짜 선택하기") {
                selectedBottomSheetType = .examDate
                isBottomSheetPresented = true
            }
        }
        .bottomSheet(
            isShowing: $isBottomSheetPresented,
            height: 453
        ) {
            if let type = selectedBottomSheetType {
                type.contentView(isPresented: $isBottomSheetPresented)
            }
        }
    }
}

#Preview {
    ExampleView()
}
