//
//  StepCircle.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StepCircle: View {
    private let step: Step
    private let complete: Bool
    
    init(step: Step, complete: Bool) {
        self.step = step
        self.complete = complete
    }
    
    var body: some View {
        Circle()
            .overlay {
                CustomText(
                    "\(step.rawValue)",
                    fontType: .caption2Bold,
                    color: complete ? Color(BBANGZIPAsset.Assets.staticWhite.color) : Color(BBANGZIPAsset.Assets.labelDisable.color)
                )
            }
            .foregroundStyle(complete ? Color(BBANGZIPAsset.Assets.statusPositive.color) : Color(BBANGZIPAsset.Assets.fillAlternative.color))
            .frame(width: 20, height: 20)
    }
}
