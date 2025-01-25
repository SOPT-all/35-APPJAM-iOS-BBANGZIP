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
    @State private var isBottomSheetShowing: Bool = false
    @State private var isTodayStudyViewBottomSheetShowing: Bool = false
    @State private var isCustomTabBarHidden = false
    
    init() {
        UIScrollView.appearance().bounces = false
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(resource: .materialDimmer)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(resource: .materialDimmer).withAlphaComponent(0.16)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    switch selected {
                    case .subjectManage:
                        SubjectManageView(
                            viewModel: SubjectManageViewModel(
                                fetchSubjectUseCase: DefaultFetchSubjectUseCase(
                                    subjectRepository: DefaultSubjectRepository()
                                ),
                                deleteSubjectUseCase: DefaultDeleteSubjectUseCase(
                                    repository: DefaultSubjectRepository()
                                )
                            ),
                            isBottomSheetShowing: $isBottomSheetShowing,
                            isCustomTabBarHidden: $isCustomTabBarHidden
                        )
                    case .todo:
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
                            ),
                            isBottomSheetShowing: $isTodayStudyViewBottomSheetShowing
                        )
                    case .networking:
                        FriendListView()
                    case .mypage:
                        MyPageMainView(
                            viewModel: MyPageMainViewModel(
                                fetchMyPageUseCase: DefaultFetchMyPageUseCase(
                                    repository: DefaultUserRepository()
                                )
                            ),
                            isCustomTabBarHidden: $isCustomTabBarHidden
                        )
                    }
                    
                    if !isBottomSheetShowing &&
                        !isTodayStudyViewBottomSheetShowing &&
                        !isCustomTabBarHidden {
                        VStack(alignment: .center) {
                            Spacer()
                            
                            CustomTabBar(selected: $selected)
                        }
                    }
                    
                }
            }
        }
    }
}
