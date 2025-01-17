//
//  TestView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct TestView: View {
    @State private var isBottomSheetPresented = false
    @State private var bottomSheetType: BottomSheetType? = .examDate
    
    @State private var selectedYear = Calendar.current.component(
        .year,
        from: Date()
    )
    @State private var selectedMonth = Calendar.current.component(
        .month,
        from: Date()
    )
    @State private var selectedDay = Calendar.current.component(
        .day,
        from: Date()
    )
    @State private var selectedSemester = "1학기"
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Test View")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Button("시험 날짜 설정") {
                bottomSheetType = .examDate
                isBottomSheetPresented = true
            }
            Button("공부 마감 날짜 설정") {
                bottomSheetType = .studyFinishDate
                isBottomSheetPresented = true
            }
            Button("학기 변경") {
                bottomSheetType = .changeSemester
                isBottomSheetPresented = true
            }
        }
        .bottomSheet(
            isShowing: $isBottomSheetPresented,
            height: .max
        ) {
            if let type = bottomSheetType {
                switch type {
                case .examDate:
                    ExamPickerBottomSheet(
                        isPresented: $isBottomSheetPresented,
                        selectedYear: selectedYear,
                        selectedMonth: selectedMonth,
                        selectedDay: selectedDay
                    )
                case .studyFinishDate:
                    StudyDeadlinePickerBottomSheet(
                        isPresented: $isBottomSheetPresented,
                        selectedYear: selectedYear,
                        selectedMonth: selectedMonth,
                        selectedDay: selectedDay
                    )
                case .changeSemester:
                    SemesterPickerBottomSheet(
                        isPresented: $isBottomSheetPresented,
                        selectedYear: $selectedYear,
                        selectedSemester: $selectedSemester
                    )
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
