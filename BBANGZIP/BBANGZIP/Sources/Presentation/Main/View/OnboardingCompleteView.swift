//
//  OnboardingFinishView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct OnboardingCompleteView: View {
    var body: some View {
        VStack {
            HStack {
                CustomText(
                    "제 과제 빵점 오픈을\n축하합니다!",
                    fontType: .title2Bold,
                    color: Color(.labelNormal)
                )
                .padding(
                    .top,
                    81
                )
                .padding(
                    .bottom,
                    36
                )
                
                Spacer()
            }
            .padding(
                .leading,
                4
            )
            
            Spacer()
        }
        .padding(
            .horizontal,
            16
        )
    }
}

#Preview {
    OnboardingCompleteView()
}
