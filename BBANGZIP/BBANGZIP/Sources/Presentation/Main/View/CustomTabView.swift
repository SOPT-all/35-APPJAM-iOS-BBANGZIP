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
    @State private var isBottomSheetShowing = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                SubjectManageView(isBottomSheetShowing: $isBottomSheetShowing)
                    .tag(Tab.subjectManage)
                
                Text("오늘 할 일")
                    .tag(Tab.todo)
                
                Text("이웃 목록")
                    .tag(Tab.networking)
                
                MyPageMainView(viewModel: MyPageMainViewModel(level: 1, currentScore: 2, badgeCount: 3))
                    .tag(Tab.mypage)
            }
            
            VStack {
                Spacer()
                
                if !isBottomSheetShowing {
                    CustomTabBar(selected: $selected)
                }
            }
        }
    }
}

#Preview {
    CustomTabView()
}
