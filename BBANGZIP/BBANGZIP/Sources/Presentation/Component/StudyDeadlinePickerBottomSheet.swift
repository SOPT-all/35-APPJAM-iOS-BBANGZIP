//
//  StudyDeadlinePickerBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyDeadlinePickerBottomSheet: View {
    @Binding var isPresented: Bool
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack(spacing: 16) {
            Text("언제까지 공부할까요?")
                .font(.headline)
                .padding(.top)
            
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
            
            Button("공부 기한 입력하기") {
                withAnimation {
                    isPresented = false
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .padding()
    }
}
