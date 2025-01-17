//
//  SemesterPickerBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SemesterPickerBottomSheet: View {
    @Binding private var isPresented: Bool
    @Binding private var selectedYear: Int
    @Binding private var selectedSemester: String
    
    private let years = Array(2025...2027)
    private let semesters = [
        "1학기",
        "2학기",
        "여름학기",
        "겨울학기"
    ]
    
    init(
        isPresented: Binding<Bool>,
        selectedYear: Binding<Int>,
        selectedSemester: Binding<String>
    ) {
        self._isPresented = isPresented
        self._selectedYear = selectedYear
        self._selectedSemester = selectedSemester
    }
    
    var body: some View {
        VStack(spacing: 16) {
            headerView
            pickersView
            actionButton
        }
        .padding()
    }
    
    private var headerView: some View {
        CustomText(
            "어떤 학기로 변경할까요?",
            fontType: .headline1Medium,
            color: Color(.labelNeutral)
        )
    }
    
    private var pickersView: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                yearPicker
                semesterPicker
            }
        }
        .frame(height: 212)
        .padding(20)
    }
    
    private var yearPicker: some View {
        Picker(
            selection: $selectedYear,
            label: Text("")
        ) {
            ForEach(
                years,
                id: \.self
            ) { year in
                CustomText(
                    "\(year)년",
                    fontType: .heading2Bold,
                    color: Color(.labelStrong)
                )
                .tag(year)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(
            .trailing,
            -15
        )
        .clipped()
    }
    
    private var semesterPicker: some View {
        Picker(
            selection: $selectedSemester,
            label: Text("")
        ) {
            ForEach(
                semesters,
                id: \.self
            ) { semester in
                CustomText(
                    semester,
                    fontType: .heading2Bold,
                    color: Color(.labelStrong)
                )
                .tag(semester)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(
            .leading,
            -15
        )
        .clipped()
    }
    
    private var actionButton: some View {
        Button(action: {
            withAnimation {
                isPresented = false
            }
        }) {
            Text("학기 변경하기")
        }
        .buttonStyle(SolidButton())
        .padding(.horizontal)
    }
}
