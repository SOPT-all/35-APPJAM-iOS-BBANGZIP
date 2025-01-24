//
//  MyPageBottomSheet.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct MyPageBottomSheet: View {
    let title: String
    let primaryButtonTitle: String
    let primaryButtonAction: () -> Void
    @Binding var isBottonSheetShowing: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            CustomText(
                title,
                fontType: .headline1Bold,
                color: Color(.labelNeutral)
            ).frame(height: 56)
            
            VStack (spacing: 8) {
                Button(primaryButtonTitle){
                    print("primaryButtonAction")
                }.buttonStyle(SolidButton())
                    .padding(.horizontal, 20)
                
                Button("취소") {
                    isBottonSheetShowing = false
                }.buttonStyle(OutlinedLargeButton())
                    .padding(.horizontal, 20)
            }
        }
    }
}

