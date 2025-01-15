//
//  DatePickerBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct DatePickerBottomSheet: View {
    @Binding var isPresented: Bool
    @Binding var selectedDate: Date

    var body: some View {
        if isPresented {
            VStack(spacing: 16) {
                Text("시험이 언제인가요?")
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
                    Text("시험 일자 입력하기")
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

    return DatePickerBottomSheet(isPresented: $isPresented, selectedDate: $selectedDate)
}
