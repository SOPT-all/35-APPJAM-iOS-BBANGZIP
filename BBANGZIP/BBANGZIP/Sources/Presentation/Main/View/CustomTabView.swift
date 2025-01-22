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
    @State private var isTodayStudyViewBottomSheetShowing: Bool
    @State private var isCustomTabBarHidden = false
    
    init(
        isBottomSheetShowing: Bool = false,
        isTodayStudyViewBottomSheetShowing: Bool = false
    ) {
        self.isBottomSheetShowing = isBottomSheetShowing
        self.isTodayStudyViewBottomSheetShowing = isTodayStudyViewBottomSheetShowing
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                TabView(selection: $selected) {
                    SubjectManageView(isBottomSheetShowing: $isBottomSheetShowing, isCustomTabBarHidden: $isCustomTabBarHidden)
                        .tag(Tab.subjectManage)
                    
                    TodayStudyView(
                        viewModel: TodayStudyViewModel(
                            fetchTodayStudyUseCase: DefaultFetchTodayStudyUseCase(
                                studyRepository: DefaultStudyRepository()
                            ),
                            completeTodayStudyUseCase: DefaultCompleteTodayStudyUseCase(
                                repository: DefaultStudyRepository()
                            ),
                            revertCompleteTodayStudyUseCase: DefaultRevertCompleteTodayStudyUseCase(
                                repository: DefaultStudyRepository()
                            ),
                            removeTodayStudyUseCase: DefaultRemoveTodayStudyUseCase(
                                repository: DefaultStudyRepository()
                            )
                        ), isBottomSheetShowing: $isTodayStudyViewBottomSheetShowing
                    )
                    .tag(Tab.todo)
                    
                    Text("오늘 할 일")
                        .tag(Tab.todo)
                
                    Text("이웃 목록")
                        .tag(Tab.networking)
                
                    MyPageMainView(
                        viewModel: MyPageMainViewModel(
                            level: 2,
                            currentScore: 40,
                            badgeCount: 8,
                            maxScore: 200,
                            title: "가판대",
                            badgeStatement: "빵집을 시작한지 얼마 안된\n사장님의 첫 빵집이에요"
                        )
                    )
                    .tag(Tab.mypage)
                }
            }
            
            VStack {
                Spacer()
                
                if !isBottomSheetShowing &&
                    !isTodayStudyViewBottomSheetShowing &&
                    !isCustomTabBarHidden {
                    CustomTabBar(selected: $selected)
                }
            }
        }
    }
}

#Preview {
    CustomTabView()
}
