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
                Image(.chevronLeftThickSmall)
                    .renderingMode(.template)
                    .foregroundStyle(Color(.labelAlternative))
                Spacer()
            }
            .padding(
                .top,
                16
            )
            
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
            
            Button("빵점 탈출하러 가기") {
                // TODO: 버튼 터치 시 화면 전환 로직 추가 필요
            }
            .buttonStyle(SolidIconButton(buttonImage: Image(.chevronRightThickSmall)))
            .padding(
                .horizontal,
                4
            )
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
