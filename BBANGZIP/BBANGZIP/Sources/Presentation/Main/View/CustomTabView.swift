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
                
                CustomTabBar(selected: $selected)
            }
        }
    }
}

#Preview {
    CustomTabView()
}
