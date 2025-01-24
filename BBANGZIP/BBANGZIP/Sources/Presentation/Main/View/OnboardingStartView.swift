//
//  WelcomeView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct OnboardingStartView: View {
    var body: some View {
        ZStack{
            Image(.onboarding)
                .frame(width: 320, height: 360)
                .padding(.top, 44)
            Spacer() 
            VStack {
                HStack {
                    CustomText(
                        "제 과제 빵점에 오신 것을\n환영합니다!",
                        fontType: .title2Bold,
                        color: Color(.labelNormal)
                    )
                    .padding(
                        .top,
                        121
                    )
                    .padding(
                        .bottom,
                        36
                    )
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
}

#Preview {
    OnboardingStartView()
}
