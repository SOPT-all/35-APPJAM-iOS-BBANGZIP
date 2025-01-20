//
//  SemesterInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SemesterInputView: View {
    @Binding var nickname: String
    @Binding var selectedYear: Int
    @Binding var selectedSemester: Semester
    @State private var isPickerPresented: Bool = false
    
    private let years = Array(2025...2028)
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                headerDescription
                
                mainDescription
                
                HStack(spacing: 0) {
                    yearPicker
                    
                    semesterPicker
                }
                
                Spacer()
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var headerDescription: some View {
        HStack {
            CustomText(
                "\(nickname) 사장님, 안녕하세요!",
                fontType: .body2Bold,
                color: Color(.labelAlternative)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            8
        )
    }
    
    private var mainDescription: some View {
        HStack {
            CustomText(
                "현재 재학 중인\n학기를 알려주세요",
                fontType: .title2Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            32
        )
    }
    
    private var yearPicker: some View {
        Picker(
            "Year",
            selection: $selectedYear
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
            .leading,
            -5
        )
        .padding(
            .trailing,
            -15
        )
        .clipped()
    }
    
    private var semesterPicker: some View {
        Picker(
            "Semester",
            selection: $selectedSemester
        ) {
            ForEach(
                Semester.allCases,
                id: \.self
            ) { semester in
                CustomText(
                    semester.rawValue,
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
        .padding(
            .trailing,
            -5
        )
        .clipped()
    }
}

#Preview {
    SemesterInputView(
        nickname: .constant("홍시"),
        selectedYear: .constant(2025),
        selectedSemester: .constant(Semester.summer)
    )
}


