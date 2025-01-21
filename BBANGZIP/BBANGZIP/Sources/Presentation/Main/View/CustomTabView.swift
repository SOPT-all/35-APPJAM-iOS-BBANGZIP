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
    @State private var isBottomSheetShowing: Bool
    @State private var isCustomTabBarHidden = false
    
    init(isBottomSheetShowing: Bool = false) {
        self.isBottomSheetShowing = isBottomSheetShowing
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {
            NavigationStack{
                TabView(selection: $selected) {
                    Group {
                        SubjectManageView(isBottomSheetShowing: $isBottomSheetShowing, isCustomTabBarHidden: $isCustomTabBarHidden)
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
            }
            
            VStack {
                Spacer()
                
                if !isBottomSheetShowing && !isCustomTabBarHidden {
                    CustomTabBar(selected: $selected)
                }
            }
        }
    }
}

#Preview {
    CustomTabView()
}
