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
    case divideStudy
    case completeCheck
    
    @MainActor @ViewBuilder
    func contentView(
        isPresented: Binding<Bool>,
        selectedYear: Binding<Int>? = .constant(2025),
        selectedMonth: Binding<Int>? = .constant(1),
        selectedDay: Binding<Int>? = .constant(1),
        isButtonTapped: Binding<Bool> = .constant(false)
    ) -> some View {
        switch self {
        case .examDate:
            ExamPickerBottomSheet(
                isPresented: isPresented,
                selectedYear: selectedYear ?? .constant(2025),
                selectedMonth: selectedMonth ?? .constant(1),
                selectedDay: selectedDay ?? .constant(1),
                isButtonTapped: isButtonTapped
            )
        case .studyFinishDate:
            StudyDeadlinePickerBottomSheet(
                isPresented: isPresented,
                selectedYear: selectedYear ?? .constant(2025),
                selectedMonth: selectedMonth ?? .constant(1),
                selectedDay: selectedDay ?? .constant(1),
                isButtonTapped: isButtonTapped
            )
        case .changeSemester:
            SemesterPickerBottomSheet(
                isPresented: isPresented,
                selectedYear: .constant(2025),
                selectedSemester: .constant("1학기")
            )
        case .divideStudy:
            SetPieceBottomSheet(
                isPresented: isPresented,
                startPage: 0,
                endPage: 0,
                totalDays: 0
            )
        case .completeCheck:
            CompleteCheckBottomSheet(
                isPresented: isPresented
            )
        default:
            Text("아직 구현되지 않은 뷰입니다.")
        }
    }
}

