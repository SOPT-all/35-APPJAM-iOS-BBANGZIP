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
    
    let years = [2025, 2026, 2027]
    let semesters = ["1학기", "2학기", "여름학기"]
    
    var body: some View {
        if isPresented {
            VStack(spacing: 16) {
                Text("어떤 학기로 변경할까요?")
                    .font(.headline)
                    .padding(.top)
                
                HStack {
                    Picker("년도", selection: $selectedYear) {
                        ForEach(years, id: \.self) { year in
                            Text("\(year)년").tag(year)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    
                    Picker("학기", selection: $selectedSemester) {
                        ForEach(semesters, id: \.self) { semester in
                            Text(semester).tag(semester)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                .frame(height: 150)
                
                Button(action: {
                    withAnimation {
                        isPresented = false
                    }
                }) {
                    Text("학기 변경하기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(.horizontal)
            .padding(.bottom, 50)
        }
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
