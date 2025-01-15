//
//  StudyDeadlinePickerBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyDeadlinePickerIntegrationView: View {
    @State private var isBottomSheetShowing = false
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation {
                    isBottomSheetShowing = true
                }
            }) {
                Text("공부 기한 선택하기")
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .bottomSheet(
            isShowing: $isBottomSheetShowing,
            height: 453
        ) {
            StudyDeadlinePickerBottomSheet(isPresented: $isBottomSheetShowing, selectedDate: $selectedDate)
        }
    }
}

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

extension View {
    func bottomSheet<Content: View>(
        isShowing: Binding<Bool>,
        height: Int,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        BottomSheet(isShowing: isShowing, height: height, content: content)
    }
}

#Preview {
    StudyDeadlinePickerIntegrationView()
}
