//
//  StudyDeadlinePickerBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyDeadlinePickerBottomSheet: View {
    @Binding private var isPresented: Bool
    @Binding private var selectedYear: Int
    @Binding private var selectedMonth: Int
    @Binding private var selectedDay: Int
    @Binding private var selectedDeadline: String
    @Binding private var isButtonTapped: Bool
    private let fixedExamDate: Date
    
    private let years = Array(2021...2028)
    private let months = Array(1...12)
    private let today: Date = Date()
    private let currentYear: Int
    private let currentMonth: Int
    private let currentDay: Int
    private let deadlineDate: String
    
    init(
        isPresented: Binding<Bool>,
        selectedYear: Binding<Int>,
        selectedMonth: Binding<Int>,
        selectedDay: Binding<Int>,
        selectedDeadline: Binding<String>,
        isButtonTapped: Binding<Bool>,
        fixedExamDate: Date
    ) {
        self._isPresented = isPresented
        self._selectedYear = selectedYear
        self._selectedMonth = selectedMonth
        self._selectedDay = selectedDay
        self._selectedDeadline = selectedDeadline
        self.fixedExamDate = fixedExamDate
        let calendar = Calendar.current
        let components = calendar.dateComponents(
            [
                .year,
                .month,
                .day
            ],
            from: today
        )
        self.currentYear = components.year ?? selectedYear.wrappedValue
        self.currentMonth = components.month ?? selectedMonth.wrappedValue
        self.currentDay = components.day ?? selectedDay.wrappedValue
        self.deadlineDate = "\(currentYear)년 \(currentMonth)월 \(currentDay)일"
        self._isButtonTapped = isButtonTapped
    }
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            pickersView
            Spacer()
            actionButton
        }
        .padding(.top, 30)
    }
    
    private var headerView: some View {
        CustomText(
            "언제까지 공부할까요?",
            fontType: .headline1Medium,
            color: Color(.labelNeutral)
        )
        .padding(.top, 0)
    }
    
    private var pickersView: some View {
        HStack(spacing: 0) {
            yearPicker
            monthPicker
            dayPicker
        }
        .padding(
            .horizontal,
            20
        )
    }
    
    private var yearPicker: some View {
        Picker(
            selection: $selectedYear,
            label: Text("")
        ) {
            ForEach(
                validYears.filter { $0 >= currentYear },
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
            -25
        )
        .clipped()
        .onChange(of: selectedYear) { _ in
            updateSelectedDay()
        }
    }
    
    private var monthPicker: some View {
        Picker(
            selection: $selectedMonth,
            label: Text("")
        ) {
            ForEach(
                validMonths,
                id: \.self
            ) { month in
                CustomText(
                    "\(month)월",
                    fontType: .heading2Bold,
                    color: Color(.labelStrong)
                )
                .tag(month)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(
            .leading,
            -25
        )
        .padding(
            .trailing,
            -25
        )
        .clipped()
        .onChange(
            of: selectedMonth
        ) { _ in
            updateSelectedDay()
        }
    }
    
    private var dayPicker: some View {
        Picker(
            selection: $selectedDay,
            label: Text("")
        ) {
            ForEach(
                validDays(
                    for: selectedYear,
                    month: selectedMonth
                ).filter { isValidDay($0) },
                id: \.self
            ) { day in
                CustomText(
                    "\(day)일",
                    fontType: .heading2Bold,
                    color: Color(.labelStrong)
                )
                .tag(day)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .padding(
            .leading,
            -25
        )
        .clipped()
    }
    
    private var actionButton: some View {
        Button(action: {
            selectedDeadline = "\(selectedYear)년 \(selectedMonth)월 \(selectedDay)일"
            isButtonTapped = true
            withAnimation { isPresented = false }
        }) {
            Text("공부 기한 입력하기")
        }
        .buttonStyle(SolidButton())
        .padding(
            .horizontal,
            20
        )
        .padding(
            .bottom,
            44
        )
    }
    
    private var validYears: [Int] {
        let fixedExamYear = Calendar.current.component(
            .year,
            from: fixedExamDate
        )
        return years.filter { $0 >= currentYear && $0 <= fixedExamYear }
    }

    private var validMonths: [Int] {
        let fixedExamYear = Calendar.current.component(
            .year,
            from: fixedExamDate
        )
        let fixedExamMonth = Calendar.current.component(
            .month,
            from: fixedExamDate
        )
        
        if selectedYear == currentYear {
            return months.filter { $0 >= currentMonth && $0 <= (selectedYear == fixedExamYear ? fixedExamMonth : 12) }
        } else if selectedYear == fixedExamYear {
            return months.filter { $0 <= fixedExamMonth }
        }
        
        return months
    }

    private func validDays(
        for year: Int,
        month: Int
    ) -> [Int] {
        let fixedExamYear = Calendar.current.component(
            .year,
            from: fixedExamDate
        )
        let fixedExamMonth = Calendar.current.component(
            .month,
            from: fixedExamDate
        )
        let fixedExamDay = Calendar.current.component(
            .day,
            from: fixedExamDate
        )

        let daysInMonth = calculateDaysInMonth(
            year: year,
            month: month
        )

        if year == currentYear && month == currentMonth {
            
            return daysInMonth.filter { $0 >= currentDay }
        } else if year == fixedExamYear && month == fixedExamMonth {
            
            return daysInMonth.filter { $0 <= fixedExamDay }
        }
        
        return daysInMonth
    }

    private func isValidDay(_ day: Int) -> Bool {
        if selectedYear == currentYear && selectedMonth == currentMonth {
            return day >= currentDay
        }
        
        return true
    }
    
    private func updateSelectedDay() {
        let days = validDays(
            for: selectedYear,
            month: selectedMonth
        )
        if !days.contains(selectedDay) {
            selectedDay = days.last ?? 1
        }
        selectedDeadline = "\(selectedYear)년 \(selectedMonth)월 \(selectedDay)일"
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
