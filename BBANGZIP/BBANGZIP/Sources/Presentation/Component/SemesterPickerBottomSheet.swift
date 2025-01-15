//
//  SemesterPickerBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SemesterPickerBottomSheet: View {
    @Binding var isPresented: Bool
    @Binding var selectedYear: Int
    @Binding var selectedSemester: String
    
    private let years = [
        2025,
        2026,
        2027
    ]
    private let semesters = [
        "1학기",
        "2학기",
        "여름학기",
        "겨울학기"
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            CustomText("어떤 학기로 변경할까요?",
                       fontType: .headline1Medium,
                       color: (BBANGZIPAsset.Assets.labelNeutral.swiftUIColor)
            )
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    Picker(selection: $selectedYear, label: Text("")) {
                        ForEach(years, id: \.self) { year in
                            CustomText("\(year)년",
                                       fontType: .heading2Bold,
                                       color: (BBANGZIPAsset.Assets.labelStrong.swiftUIColor))
                            .tag(year)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(.trailing, -15)
                    .clipped()
                    Picker(selection: $selectedSemester, label: Text("")) {
                        ForEach(semesters, id: \.self) { semester in
                            CustomText(semester,
                                       fontType: .heading2Bold,
                                       color: (BBANGZIPAsset.Assets.labelStrong.swiftUIColor))
                            .tag(semester)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .padding(.leading, -15)
                    .clipped()
                }
            }
            .frame(height: 212)
            .padding(20)
            
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
        .padding()
    }
}

#Preview {
    @State var isPresented = true
    @State var selectedYear = 2025
    @State var selectedSemester = "1학기"
    
    return SemesterPickerBottomSheet(
        isPresented: $isPresented,
        selectedYear: $selectedYear,
        selectedSemester: $selectedSemester
    )
}
