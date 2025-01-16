//
//  CustomTabView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView {
            Text("과목 관리")
                .tabItem {
                    Image(.subjectManage)
                        .renderingMode(.template)
                        .foregroundStyle(Color(.labelAssistive))
                    CustomText(
                        "과목 관리",
                        fontType: .caption1Bold,
                        color: Color(.labelAssistive)
                    )
                }
            Text("오늘 할 일")
                .tabItem {
                    Image(.todo)
                        .renderingMode(.template).foregroundStyle(Color(.labelAssistive))
                    CustomText(
                        "오늘 할 일",
                        fontType: .caption1Bold,
                        color: Color(.labelAssistive)
                    )
                }
            Text("이웃 목록")
                .tabItem {
                    Image(.networking)
                        .renderingMode(.template).foregroundStyle(Color(.labelAssistive))
                    CustomText(
                        "이웃 목록",
                        fontType: .caption1Bold,
                        color: Color(.labelAssistive)
                    )
                }
            Text("마이페이지")
                .tabItem {
                    Image(.myPage)
                        .renderingMode(.template).foregroundStyle(Color(.labelAssistive))
                    CustomText(
                        "마이페이지",
                        fontType: .caption1Bold,
                        color: Color(.labelAssistive)
                    )
                }
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = UIColor(Color(.backgroundNormal))
        }
        .accentColor(Color(.labelNormal))
    }
}

#Preview {
    CustomTabView()
}
