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
        ProgressView(value: 1) {
            HStack {
                BbangText(
                    "1",
                    fontType: .caption2,
                    color: Color(BBANGZIPAsset.Assets.staticWhite.color)
                )
                .background(
                    Capsule()
                        .fill(Color(BBANGZIPAsset.Assets.statusPositive.color))
                        .frame(width: 20, height: 20)
                )
                
                Spacer()
                
                if category.percentage > 0.04 {
                    BbangText(
                        "2",
                        fontType: .caption2,
                        color: Color(BBANGZIPAsset.Assets.staticWhite.color)
                    )
                    .background(
                        Capsule()
                            .fill(Color(BBANGZIPAsset.Assets.statusPositive.color))
                            .frame(width: 20, height: 20)
                    )
                }
                
                Spacer()
                
                if category.percentage > 0.5 {
                    BbangText(
                        "3",
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
            .padding(.leading, 7)
            .padding(.trailing, 6.5)
            .padding(.bottom, 8)
        }
        .progressViewStyle(ProgressBarStyle())
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
