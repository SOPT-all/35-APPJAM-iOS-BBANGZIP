//
//  ExamPickerBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ExamPickerBottomSheet: View {
    @Binding private var isPresented: Bool
    @State private var selectedYear: Int
    @State private var selectedMonth: Int
    @State private var selectedDay: Int
    
    private let years = Array(2021...2028)
    private let months = Array(1...12)
    
    private var days: [Int] {
        calculateDaysInMonth(
            year: selectedYear,
            month: selectedMonth
        )
    }
    
    private let today: Date = Date()
    private let currentYear: Int
    private let currentMonth: Int
    private let currentDay: Int
    
    init(
        isPresented: Binding<Bool>,
        selectedYear: Int,
        selectedMonth: Int,
        selectedDay: Int
    ) {
        self._isPresented = isPresented
        self._selectedYear = State(initialValue: selectedYear)
        self._selectedMonth = State(initialValue: selectedMonth)
        self._selectedDay = State(initialValue: selectedDay)
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [
                .year,
                .month,
                .day
            ],
            from: today
        )
        self.currentYear = components.year ?? selectedYear
        self.currentMonth = components.month ?? selectedMonth
        self.currentDay = components.day ?? selectedDay
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
            "시험이 언제인가요?",
            fontType: .headline1Medium,
            color: (BBANGZIPAsset.Assets.labelNeutral.swiftUIColor)
        )
    }
    
    private var pickersView: some View {
        HStack(spacing: 0) {
            yearPicker
            monthPicker
            dayPicker
        }
        .padding(.horizontal, 20)
    }
    
    private var yearPicker: some View {
        Picker(selection: $selectedYear, label: Text("")) {
            ForEach(
                years.filter {
                    $0 >= currentYear
                },
                id: \.self) { year in
                CustomText("\(year)년",
                           fontType: .heading2Bold,
                           color: (BBANGZIPAsset.Assets.labelStrong.swiftUIColor))
                .tag(year)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(.trailing, -25)
        .clipped()
        .onChange(
            of: selectedYear
        ) {
            _ in updateSelectedDay()
        }
    }
    
    private var monthPicker: some View {
        Picker(selection: $selectedMonth, label: Text("")) {
            ForEach(validMonths, id: \.self) { month in
                CustomText("\(month)월",
                           fontType: .heading2Bold,
                           color: (BBANGZIPAsset.Assets.labelStrong.swiftUIColor))
                .tag(month)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(.leading, -25)
        .padding(.trailing, -25)
        .clipped()
        .onChange(
            of: selectedMonth
        ) {
            _ in updateSelectedDay()
        }
    }
    
    private var dayPicker: some View {
        Picker(selection: $selectedDay, label: Text("")) {
            ForEach(days.filter { isValidDay($0) }, id: \.self) { day in
                CustomText("\(day)일",
                           fontType: .heading2Bold,
                           color: (BBANGZIPAsset.Assets.labelStrong.swiftUIColor))
                .tag(day)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(.leading, -25)
        .clipped()
    }
    
    private var actionButton: some View {
        Button(action: {
            withAnimation {
                isPresented = false
            }
        }) {
            Text("시험 일자 입력하기")
        }
        .buttonStyle(SolidButton())
        .padding(.horizontal)
    }
    
    private var validMonths: [Int] {
        if selectedYear == currentYear {
            return months.filter { $0 >= currentMonth }
        }
        
        return months
    }
    
    private func isValidDay(_ day: Int) -> Bool {
        if selectedYear == currentYear, selectedMonth == currentMonth {
            return day >= currentDay
        }
        
        return true
    }
    
    private func updateSelectedDay() {
        if !days.contains(selectedDay) {
            selectedDay = days.last ?? 1
        }
    }
    
    private func calculateDaysInMonth(
        year: Int,
        month: Int
    ) -> [Int] {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        let dateComponents = DateComponents(
            year: year,
            month: month
        )
        if let date = calendar.date(from: dateComponents),
           let range = calendar.range(
            of: .day,
            in: .month,
            for: date
           ) {
            return Array(range)
        }
        
        return []
    }
}
