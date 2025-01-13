//
//  ProgressBar.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum Step {
    case First
    case Second
    case Third
    
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
    var category: Step = .First
    
    var body: some View {
        ProgressView(value: category.percentage) {
            
            HStack {
                StepCircle(step: 1)
                
                Spacer()
                
                if category != .First {
                    StepCircle(step: 2)
                }
                else {
                    StepCircle(step: 2, complete: false)
                }
                
                Spacer()
                
                if category == .Third {
                    StepCircle(step: 3)
                }
                else {
                    StepCircle(step: 3, complete: false)
                }
            }
            .padding(.bottom, 8)
        }
        .progressViewStyle(ProgressBarStyle())
    }
}

struct StepCircle: View {
    var step: Int
    var complete: Bool = true
    
    var body: some View {
        Circle()
            .overlay {
                BbangText(
                    "\(step)",
                    fontType: .caption2,
                    color: complete ? Color(BBANGZIPAsset.Assets.staticWhite.color) : Color(BBANGZIPAsset.Assets.labelDisable.color)
                )
            }
            .foregroundStyle(complete ? Color(BBANGZIPAsset.Assets.statusPositive.color) : Color(BBANGZIPAsset.Assets.fillAlternative.color))
            .frame(width: 20, height: 20)
    }
}

struct ProgressBarStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .progressViewStyle(LinearProgressViewStyle(tint: Color(BBANGZIPAsset.Assets.statusPositive.color)))
    }
}

#Preview {
    ProgressBar()
}
