//
//  ProgressBar.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    private var type: ProgressBarType
    
    init(type: ProgressBarType) {
        self.type = type
    }
    
    var body: some View {
        VStack {
            switch type {
            case .withCircle(let category):
                ProgressView(value: category.percentage) {
                    HStack {
                        StepCircle(
                            step: Step.first,
                            complete: category.rawValue >= Step.first.rawValue
                        )
                        
                        Spacer()
                        
                        StepCircle(
                            step: Step.second,
                            complete: category.rawValue >= Step.second.rawValue
                        )
                        
                        Spacer()
                        
                        StepCircle(
                            step: Step.third,
                            complete: category.rawValue >= Step.third.rawValue
                        )
                    }
                    .padding(.bottom, 8)
                }
                .progressViewStyle(LinearProgressViewStyle())
                .tint(Color(.labelNormal))
                
            case .basic(let progress):
                ProgressView(value: progress)
                    .progressViewStyle(CustomProgressBar())
            }
        }
    }
}
struct CustomProgressBar: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.staticWhite))
                    .frame(height: 8)
                
                if let fractionCompleted = configuration.fractionCompleted {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.primaryLight))
                        .frame(
                            width: geometry.size.width * CGFloat(fractionCompleted),
                            height: 8
                        )
                }
            }
        }
        .frame(height: 8)
    }
}
