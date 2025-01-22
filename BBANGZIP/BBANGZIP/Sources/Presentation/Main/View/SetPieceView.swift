//
//  DivideStudyView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SetPieceView: View {
    @State private var isBottomSheetPresented = true
    @State private var selectedBottomSheetType: BottomSheetType? = .divideStudy
    @State private var selectedYear: Int
    @State private var selectedMonth: Int
    @State private var selectedDay: Int
    @State private var isButtonTapped: Bool
    
    // TODO: 임시 뷰모델 수정 필요
    init(viewModel: AddStudyViewModel = AddStudyViewModel(),
         isBottomSheetPresented: Bool = false,
         isButtonTapped: Bool = false
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.isBottomSheetPresented = isBottomSheetPresented
        self.isButtonTapped = isButtonTapped
        
        let calendar = Calendar.current
        let today = Date()
        self._selectedYear = State(
            initialValue: calendar.component(
                .year,
                from: today
            )
        )
        self._selectedMonth = State(
            initialValue: calendar.component(
                .month,
                from: today
            )
        )
        self._selectedDay = State(
            initialValue: calendar.component(
                .day,
                from: today
            )
        )
    }
    
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
                    type.contentView(
                        isPresented: $isBottomSheetPresented,
                        selectedYear: $selectedYear,
                        selectedMonth: $selectedMonth,
                        selectedDay: $selectedDay,
                        isButtonTapped: $isButtonTapped
                    )
                }
            }
    }
}

#Preview {
    SetPieceView()
}

