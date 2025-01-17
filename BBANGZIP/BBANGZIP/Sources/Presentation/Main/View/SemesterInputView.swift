//
//  SemesterInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SemesterInputView: View {
    @State private var currentStep: Step
    @State private var nickname: String
    @State private var selectedYear: Int
    @State private var selectedSemester: Semester
    @State private var isPickerPresented: Bool
    
    init(
        // TODO: 부모 뷰에서 공통적으로 사용할 currentStep은 삭제 필요
        currentStep: Step = .Second,
        nickname: String,
        selectedYear: Int,
        selectedSemester: Semester,
        isPickerPresented: Bool = false
    ) {
        self.currentStep = currentStep
        self.nickname = nickname
        self.selectedYear = selectedYear
        self.selectedSemester = selectedSemester
        self.isPickerPresented = isPickerPresented
    }
    
    private let years = Array(2025...2028)
    
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
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                backButton
            }
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
    
    private var backButton: some View {
        Button(action: {
            // TODO: 뒤로가기 버튼 누르면 상태 변경
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
    SemesterInputView(
        nickname: "홍시",
        selectedYear: 2025,
        selectedSemester: Semester.summer
    )
}


