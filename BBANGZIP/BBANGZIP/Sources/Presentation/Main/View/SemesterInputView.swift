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
    
    private let years = Array(2025...2027)
    private let semesters = [
        "1학기",
        "2학기",
        "여름학기",
        "겨울학기"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(.chevronLeftThickSmall)
                    .renderingMode(.template)
                    .foregroundStyle(Color(.labelAlternative))
                Spacer()
            }
            .padding(16)
            
            ProgressBar(category: $currentStep)
                .padding(.horizontal, 44)
                .padding(.bottom, 78)
            
            VStack(spacing: 0) {
                HStack {
                    CustomText(
                        "\(nickname), 안녕하세요!",
                        fontType: .body2Bold,
                        color: Color(.labelAlternative)
                    )
                    
                    Spacer()
                }
                .padding(.bottom, 8)
                
                HStack {
                    CustomText(
                        "현재 재학 중인 학기를\n알려주세요",
                        fontType: .title2Bold,
                        color: Color(.labelNormal)
                    )
                    
                    Spacer()
                }
                .padding(.bottom, 32)
                
                HStack {
                    Picker("Year", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            CustomText(
                                "\(year)년",
                                fontType: .heading2Bold,
                                color: Color(.labelStrong)
                            )                                .tag(year)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 120, height: 180)
                    .clipped()
                    
                    Picker("Semester", selection: $selectedSemester) {
                        ForEach(semesters, id: \.self) { semester in
                            Text(semester)
                                .font(.system(size: 18, weight: .bold))
                                .tag(semester)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 120, height: 180)
                    .clipped()
                }
                .padding(.bottom, 32)
                
                Spacer()
                
                Button("다음으로") {
                    
                }
                .buttonStyle(SolidIconButton(buttonImage: Image(.chevronLeftThickSmall)))
            }
            .padding(.horizontal, 20)
        }
    }
    
}

#Preview {
    SemesterInputView()
}

