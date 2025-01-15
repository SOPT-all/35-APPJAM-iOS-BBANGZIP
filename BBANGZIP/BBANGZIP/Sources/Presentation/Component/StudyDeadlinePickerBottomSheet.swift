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
        if isPresented {
            VStack(spacing: 16) {
                Text("언제까지 공부할까요?")
                    .font(.headline)
                    .padding(.top)
                
                DatePicker("", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                
                Button(action: {
                    withAnimation {
                        isPresented = false
                    }
                }) {
                    Text("공부 기한 입력하기")
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
    @State var selectedDate = Date()
    
    return StudyDeadlinePickerBottomSheet(isPresented: $isPresented, selectedDate: $selectedDate)
}
