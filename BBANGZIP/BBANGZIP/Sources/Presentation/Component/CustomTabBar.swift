//
//  CustomTabBar.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selected: Tab
    
    var body: some View {
        HStack {
            CustomTabButton(
                tab: .subjectManage,
                selected: $selected
            )
            
            Spacer()
            
            CustomTabButton(
                tab: .todo,
                selected: $selected
            )
            
            Spacer()
            
            CustomTabButton(
                tab: .networking,
                selected: $selected
            )
            
            Spacer()
            
            CustomTabButton(
                tab: .mypage,
                selected: $selected
            )
        }
        .padding(
            .horizontal,
            12
        )
        .padding(
            .top,
            12
        )
        .padding(
            .bottom,
            4
        )
        .background(
            Color(.backgroundNormal)
                .clipShape(
                    UnevenRoundedRectangle(
                        cornerRadii: RectangleCornerRadii(
                            topLeading: 32,
                            bottomLeading: 0,
                            bottomTrailing: 0,
                            topTrailing: 32
                        )
                    )
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.25),
                    radius: 4,
                    y: -4
                )
                .edgesIgnoringSafeArea(.bottom)
        )
    }
}
