//
//  ProgressBar.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum Step: Int{
    case First = 1
    case Second = 2
    case Third = 3
    
    var percentage: CGFloat {
        switch self {
        case .First:
            0.04
        case .Second:
            0.5
        case .Third:
            1
        }
    }
}

struct ProgressBar: View {
    private let category: Step
    
    init(category: Step) {
        self.category = category
    }
    
    var body: some View {
        ProgressView(value: category.percentage) {            
            HStack {
                StepCircle(step: category, complete: true)
                
                Spacer()
                
                StepCircle(step: category, complete: category != .First)
                
                Spacer()
                
                StepCircle(step: category, complete: category == .Third)
            }
            .padding(.bottom, 8)
        }
        .progressViewStyle(LinearProgressViewStyle(tint: Color(BBANGZIPAsset.Assets.statusPositive.color)))
    }
}
