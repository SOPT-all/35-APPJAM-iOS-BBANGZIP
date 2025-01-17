//
//  CustomTabView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selected: Tab = .subjectManage
    
    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                Group {
                    Text("과목 관리")
                        .tag(Tab.subjectManage)
                    
                    Text("오늘 할 일")
                        .tag(Tab.todo)
                    
                    Text("이웃 목록")
                        .tag(Tab.networking)
                    
                    Text("마이페이지")
                        .tag(Tab.mypage)
                }
                .toolbar(
                    .hidden,
                    for: .tabBar
                )
            }
            
            VStack {
                Spacer()
                
                tabBar
            }
        }
    }
    
    var tabBar: some View {
        HStack {
            CustomTabButton(tab: .subjectManage, selected: $selected)
            
            Spacer()
            
            CustomTabButton(tab: .todo, selected: $selected)
            
            Spacer()
            
            CustomTabButton(tab: .networking, selected: $selected)
            
            Spacer()
            
            CustomTabButton(tab: .mypage, selected: $selected)
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

#Preview {
    CustomTabView()
}
