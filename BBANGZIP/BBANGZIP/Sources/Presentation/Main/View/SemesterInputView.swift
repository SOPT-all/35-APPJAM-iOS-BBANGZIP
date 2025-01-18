//
//  SemesterInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SemesterInputView: View {
    @State private var currentStep: Step = .Second
    @State private var nickname: String = "유나 사장님"
    @State private var selectedYear: Int = 2025
    @State private var selectedSemester: String = "1학기"
    @State private var isPickerPresented: Bool = false
    @SwiftUI.Environment(\.dismiss) private var dismiss
    
    private let years = Array(2025...2028)
    private let semesters = [
        "1학기",
        "2학기",
        "여름학기",
        "겨울학기"
    ]
    
    var body: some View {
        VStack(spacing: 0) {            
            ProgressBar(category: $currentStep)
                .padding(
                    .horizontal,
                    44
                )
                .padding(
                    .bottom,
                    48
                )
            
            VStack(spacing: 0) {
                headerDescription
                
                mainDescription
                
                HStack(spacing: 0) {
                    yearPicker
                    semesterPicker
                }
                .padding(
                    .bottom,
                    32
                )
                
                Spacer()
                
                nextButton
            }
            .padding(
                .horizontal,
                20
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: backButton
        )
    }
    
    private var headerDescription: some View {
        HStack {
            CustomText(
                "\(nickname), 안녕하세요!",
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
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            HStack {
                Image(.chevronLeftThickSmall)
                    .renderingMode(.template)
                    .foregroundStyle(Color(.labelAlternative))
                Spacer()
            }
        }
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
        .padding(
            .trailing,
            -5
        )
        .clipped()
    }
    
    private var nextButton: some View {
        NavigationLink("다음으로") {
            // TODO: 버튼 눌렀을 때 화면 전환 필요
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronRight)
            )
        )
    }
}

#Preview {
    SemesterInputView()
}


