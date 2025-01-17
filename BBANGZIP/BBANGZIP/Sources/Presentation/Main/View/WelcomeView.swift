//
//  WelcomeView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
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
            
            Button("빵집 오픈하러 가기") {
                // TODO: 버튼 터치 시 화면 전환 로직 추가 필요
            }
            .buttonStyle(SolidIconButton(imageName: "chevronRightThickSmall"))
        }
        .padding(
            .horizontal,
            20
        )
        
    }
}

#Preview {
    WelcomeView()
}
