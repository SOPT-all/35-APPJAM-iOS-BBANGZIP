//
//  ProgressBar.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var category: Step
    
    var body: some View {
        ProgressView(value: category.percentage) {            
            HStack {
                StepCircle(
                    step: Step.first,
                    complete: true
                )
                
                Spacer()
                
                StepCircle(
                    step: Step.second,
                    complete: category != .first
                )
                
                Spacer()
                
                StepCircle(
                    step: Step.third,
                    complete: category == .third
                )
            }
            .padding(
                .bottom,
                8
            )
        }
        .progressViewStyle(
            LinearProgressViewStyle(tint: Color(.statusPositive))
        )
    }
}
