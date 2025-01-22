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
    
    init(
        isBottomSheetShowing: Bool = false,
        isTodayStudyViewBottomSheetShowing: Bool = false
    ) {
        self.isBottomSheetShowing = isBottomSheetShowing
        self.isTodayStudyViewBottomSheetShowing = isTodayStudyViewBottomSheetShowing
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selected) {
                Group {
                    SubjectManageView(isBottomSheetShowing: $isBottomSheetShowing)
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
                
                if !isBottomSheetShowing && !isTodayStudyViewBottomSheetShowing {
                    CustomTabBar(selected: $selected)
                }
            }
        }
    }
}

#Preview {
    CustomTabView()
}
