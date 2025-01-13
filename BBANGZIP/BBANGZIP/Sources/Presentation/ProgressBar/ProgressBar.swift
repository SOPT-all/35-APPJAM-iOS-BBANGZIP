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
                ProgressBarCapsule(step: 1)
                
                Spacer()
                
                ProgressBarCapsule(step: 2)
                
                Spacer()
                
                ProgressBarCapsule(step: 3)
            }
            .padding(.leading, 7)
            .padding(.trailing, 6.5)
            .padding(.bottom, 8)
        }
        .progressViewStyle(ProgressBarStyle())
    }
}

struct ProgressBarCapsule: View {
    var step: Int
    
    var body: some View {
        BbangText(
            "\(step)",
            fontType: .caption2,
            color: Color(BBANGZIPAsset.Assets.staticWhite.color)
        )
        .background(
            Capsule()
                .fill(Color(BBANGZIPAsset.Assets.statusPositive.color))
                .frame(width: 20, height: 20)
        )
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
