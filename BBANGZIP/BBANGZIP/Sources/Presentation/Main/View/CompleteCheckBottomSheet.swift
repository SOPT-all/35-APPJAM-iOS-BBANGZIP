//
//  CompleteCheckBottomSheet.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CompleteCheckBottomSheet: View {
    @Binding private var isPresented: Bool
        
    init(
        isPresented: Binding<Bool>
    ) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        CustomText(
            "미완료 상태로 되돌릴까요?",
            fontType: .headline1Bold,
            color: Color(.labelNeutral)
        )
        .padding(
            .top,
            31
        )
        .padding(
            .bottom,
            31
        )
        
            
        VStack(spacing: 8){
            Button("되돌리기") {
                // TODO: 완료 형태 되돌리기 로직 필요
                isPresented = false
                
            }
            .buttonStyle(SolidButton())
            
            Button("취소") {
                isPresented = false
            }
            .buttonStyle(OutlinedLargeButton())
        }
        .padding(
            .horizontal,
            20
        )
    }
}
