//
//  BottomSheetType.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum BottomSheetType: Int {
    case revert
    case sort
    case withdraw
    case detailBadge
    case congratsBadge
    case examDate
    case studyFinishDate
    case changeSemester
    
    @MainActor @ViewBuilder
    func contentView(isPresented: Binding<Bool>) -> some View {
        let currentDate = Date()
        let currentYear = Calendar.current.component(
            .year,
            from: currentDate
        )
        let currentMonth = Calendar.current.component(
            .month,
            from: currentDate
        )
        let currentDay = Calendar.current.component(
            .day,
            from: currentDate
        )
        
        switch self {
        case .examDate:
            ExamPickerBottomSheet(
                isPresented: isPresented,
                selectedYear: currentYear,
                selectedMonth: currentMonth,
                selectedDay: currentDay
            )
        case .studyFinishDate:
            StudyDeadlinePickerBottomSheet(
                isPresented: isPresented,
                selectedYear: currentYear,
                selectedMonth: currentMonth,
                selectedDay: currentDay
            )
        case .changeSemester:
            SemesterPickerBottomSheet(
                isPresented: isPresented,
                selectedYear: .constant(2025),
                selectedSemester: .constant("1학기")
            )
        default:
            Text("아직 구현되지 않은 뷰입니다.")
        }
    }
}
