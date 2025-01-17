//
//  CustomTabView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomTabView: View {
    enum Tab {
        case subjectManage
        case todo
        case networking
        case mypage
    }
    
    @State private var selected: Tab = .subjectManage
    
    var body: some View {
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
            .toolbar(.hidden, for: .tabBar)
        }
    }
}

#Preview {
    CustomTabView()
}

//.tabItem {
//    Image(.subjectManage)
//        .renderingMode(.template)
//        .foregroundStyle(Color(.labelAssistive))
//    CustomText(
//        "과목 관리",
//        fontType: .caption1Bold,
//        color: Color(.labelAssistive)
//    )
//}
