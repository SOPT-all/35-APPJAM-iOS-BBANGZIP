//
//  AddStudyCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct AddStudyCard: View {
    
    var body: some View {
        ZStack {
            backgroundView
            
            HStack(spacing: 8) {
                CircleIcon(name: "Plus")
                    .frame(
                        width: 40,
                        height: 40
                    )
                
                CustomText(
                    "공부 추가",
                    fontType: .body1Bold,
                    color: Color(.labelDisable)
                )
            }
            .frame(height: 86)
        }
    }
    
    var backgroundView: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color(.backgroundNormal))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        Color(.lineAlternative),
                        lineWidth: 2
                    )
            )
    }
}

#Preview {
    AddStudyCard()
}
