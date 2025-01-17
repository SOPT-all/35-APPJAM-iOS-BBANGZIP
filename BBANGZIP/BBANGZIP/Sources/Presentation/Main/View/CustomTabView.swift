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
        GeometryReader { geometry in
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
                    .toolbar(.hidden, for: .tabBar)
                }
                
                VStack {
                    Spacer()
                    
                    tabBar
                }
            }
        }
    }
    
    var tabBar: some View {
        HStack {
            Button {
                selected = .subjectManage
            } label: {
                VStack(
                    alignment: .center,
                    spacing: 4
                ) {
                    Image(selected == .subjectManage ? .activeSubjectManage : .subjectManage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                        .padding(.horizontal, 24)
                    CustomText(
                        "과목 관리",
                        fontType: .caption1Bold,
                        color: selected == .subjectManage ? Color(.labelNormal) : Color(.labelAssistive)
                    )
                }
            }
            Spacer()
            
            Button {
                selected = .todo
            } label: {
                VStack(
                    alignment: .center,
                    spacing: 4
                ) {
                    Image(selected == .todo ? .activeTodo : .todo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                        .padding(.horizontal, 24)
                    CustomText(
                        "오늘 할 일",
                        fontType: .caption1Bold,
                        color: selected == .todo ? Color(.labelNormal) : Color(.labelAssistive)
                    )
                }
            }
            .foregroundStyle(selected == .todo ? Color(.labelNormal) : Color(.labelAssistive))
            
            Spacer()
            
            Button {
                selected = .networking
            } label: {
                VStack(
                    alignment: .center,
                    spacing: 4
                ) {
                    Image(selected == .networking ? .activeNetworking : .networking)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                        .padding(.horizontal, 24)
                    CustomText(
                        "이웃 목록",
                        fontType: .caption1Bold,
                        color: selected == .networking ? Color(.labelNormal) : Color(.labelAssistive)
                    )
                }
            }
            .foregroundStyle(selected == .networking ? Color(.labelNormal) : Color(.labelAssistive))
            
            Spacer()
            
            Button {
                selected = .mypage
            } label: {
                VStack(
                    alignment: .center,
                    spacing: 4
                ) {
                    Image(selected == .mypage ? .activeMyPage : .myPage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24)
                        .padding(.horizontal, 24)
                    CustomText(
                        "마이페이지",
                        fontType: .caption1Bold,
                        color: selected == .mypage ? Color(.labelNormal) : Color(.labelAssistive)
                    )
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .padding(.bottom, 4)
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
