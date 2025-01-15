//
//  ExamPickerBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ExamPickerBottomSheet: View {
    @Binding var isPresented: Bool
    @State private var selectedYear: Int
    @State private var selectedMonth: Int
    @State private var selectedDay: Int
    
    let years = Array(2021...2027)
    let months = Array(1...12)
    
    var days: [Int] {
        calculateDaysInMonth(
            year: selectedYear,
            month: selectedMonth
        )
    }
    
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
    }
    
    var body: some View {
        VStack(spacing: 16) {
            CustomText("시험이 언제인가요?",
                       fontType: .headline1Medium,
                       color: (BBANGZIPAsset.Assets.labelNeutral.swiftUIColor)
            )
            HStack(spacing: 0) {
                Picker(
                    selection: $selectedYear,
                    label: Text("")
                ) {
                    ForEach(years, id: \.self) { year in
                        CustomText("\(year)년",
                                   fontType: .heading2Bold,
                                   color: (BBANGZIPAsset.Assets.labelStrong.swiftUIColor))
                        .tag(year)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .padding(.trailing, -25)
                .clipped()
                .onChange(of: selectedYear) { _ in
                    updateSelectedDay()
                }
                
                Picker(
                    selection: $selectedMonth,
                    label: Text("")
                ) {
                    ForEach(
                        months,
                        id: \.self
                    ) { month in
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
                .onChange(of: selectedMonth) { _ in
                    updateSelectedDay()
                }
                
                Picker(selection: $selectedDay, label: Text("")) {
                    ForEach(days, id: \.self) { day in
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
            .padding(.horizontal, 20)
            
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
        .padding()
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

#Preview {
    @State var isPresented = true
    @State var selectedYear = Calendar.current.component(.year, from: Date())
    @State var selectedMonth = Calendar.current.component(.month, from: Date())
    @State var selectedDay = Calendar.current.component(.day, from: Date())
    
    return ExamPickerBottomSheet(
        isPresented: $isPresented,
        selectedYear: selectedYear,
        selectedMonth: selectedMonth,
        selectedDay: selectedDay
    )
}
