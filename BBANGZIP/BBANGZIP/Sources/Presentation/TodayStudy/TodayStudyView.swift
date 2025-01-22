//
//  TodayStudyView.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct TodayStudyView: View {
    @StateObject private var viewModel: TodayStudyViewModel
    
    init(viewModel: TodayStudyViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 0) {
                    ZStack {
                        backgroundView
                        
                        headerView
                    }
                    .padding(
                        .bottom,
                        48
                    )
                    
                    if viewModel.todayCount + viewModel.completeCount == 0 {
                        emptyView
                            .padding(
                                .bottom,
                                16
                            )
                        
                        addTodayStudyButton
                    } else {
                        announceTextView
                            .padding(
                                .bottom,
                                16
                            )
                        
                        buttonView
                            .padding(
                                .bottom,
                                24
                            )
                        
                        todayStudyList
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
            
            if viewModel.isDeleteMode {
                deleteButton
            }
            
            revertBottomSheet
            
            filterBottomSheet
        }
        .onAppear {
            Task { @MainActor in
                await viewModel.fetchData()
            }
        }
        .toastView(toast: $viewModel.toast)
    }
    
    private var backgroundView: some View {
        VStack {
            Color(.backgroundAccent)
                .cornerRadius(
                    32,
                    corners: [
                        .bottomLeft,
                        .bottomRight
                    ]
                )
                .padding(
                    .bottom,
                    24
                )
        }
    }
    
    private var headerView: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                HStack {
                    TodayStudyDateView()
                        .padding(
                            .leading,
                            8
                        )
                    
                    Spacer()
                }
                
                HStack {
                    if viewModel.pendingCount > 0 {
                        DelayedStudyButton(count: viewModel.pendingCount)
                    } else {
                        CustomText(
                            "사장님의 밀린 공부는 빵 개!",
                            fontType: .headline1Bold,
                            color: Color(.labelAlternative)
                        )
                        .padding(
                            .leading,
                            8
                        )
                    }
                    
                    Spacer()
                }
            }
            .padding(
                .leading,
                24
            )
            .padding(
                .top,
                80
            )
            
            Balloon(
                text: "사장님의 과제 빵점 탈출을 응원해요!",
                leftIcon: Image(.announcement),
                balloonMode: .top
            )
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var announceTextView: some View {
        HStack {
            VStack(alignment: .leading) {
                CustomText(
                    viewModel.completeAnnounceText,
                    fontType: .label1Bold,
                    color: Color(.labelAlternative)
                )
                
                CustomText(
                    viewModel.pendingAnnounceText,
                    fontType: .title3Bold,
                    color: Color(.labelNormal)
                )
            }
            
            Spacer()
        }
        .padding(
            .leading,
            28
        )
    }
    
    private var buttonView: some View {
        HStack {
            Spacer()
            
            if viewModel.isDeleteMode {
                Button {
                    viewModel.trashButtonTapped()
                } label: {
                    Image(.xlarge)
                        .renderingMode(.template)
                        .foregroundStyle(Color(.labelAlternative))
                }
            } else {
                HStack(spacing: 16) {
                    Button {
                        viewModel.trashButtonTapped()
                    } label: {
                        Image(.trash)
                            .renderingMode(.template)
                            .foregroundStyle(Color(.labelAlternative))
                    }
                    
                    Button {
                        viewModel.isFilterBottomSheetPresent = true
                    } label: {
                        Image(.filter)
                            .renderingMode(.template)
                            .foregroundStyle(Color(.labelAlternative))
                    }
                }
            }
        }
        .padding(
            .trailing,
            20
        )
    }
    
    private var emptyView: some View {
        RoundedRectangle(cornerRadius: 32)
            .fill(Color(.systemGray6))
            .padding(
                .horizontal,
                20
            )
            .frame(height: 308)
    }
    
    private var todayStudyList: some View {
        VStack(spacing: 12) {
            ForEach($viewModel.todoPiecesList) { $piece in
                Button {
                    if piece.state == .cardDefault {
                        piece.state = .complete
                        Task {
                            await viewModel.revertCompleteStudy()
                        }
                    } else if piece.state == .complete {
                        if viewModel.isDeleteMode {
                            viewModel.toast = Toast("이미 완료한 일은 삭제할 수 없어요")
                        } else {
                            viewModel.isRevertBottomSheetPresent.toggle()
                        }
                    } else if piece.state == .selectable {
                        piece.state = .selected
                    } else {
                        piece.state = .selectable
                    }
                    viewModel.validateDeleteButton()
                } label: {
                    StudyCard(model: piece)
                }
                .buttonStyle(PressedButtonStyle())
                .customShadow(.emphasize)
            }
        }
        .padding(.horizontal, 20)
    }
    
    private var addTodayStudyButton: some View {
        Button {
            print("오늘 할 공부 추가하기 Tapped")
        } label: {
            CustomText(
                "오늘 할 공부 추가하기",
                fontType: .body1Bold,
                color: Color(.staticWhite)
            )
        }
        .buttonStyle(SolidIconButton(buttonImage: Image(.plus)))
        .padding(
            .horizontal,
            20
        )
    }
    
    private var deleteButton: some View {
        VStack {
            Spacer()
            
            Button {
                print("삭제하기 Tapped")
                //TODO: 삭제 API 호출 -> FetchData
            } label: {
                CustomText(
                    "삭제하기",
                    fontType: .body1Bold,
                    color: viewModel.isDeleteButtonEnable ? Color(.staticWhite) : Color(.labelDisable)
                )
            }
            .buttonStyle(
                SolidIconButton(
                    buttonImage: Image(.trash),
                    viewModel.isDeleteButtonEnable
                )
            )
            .padding(
                .horizontal,
                20
            )
            .padding(
                .bottom,
                16
            )
        }
    }
    
    private var revertBottomSheet: some View {
        BottomSheet(
            isShowing: $viewModel.isRevertBottomSheetPresent,
            height: 265
        ) {
            VStack(spacing: 0) {
                CustomText(
                    "미완료 상태로 되돌릴까요?",
                    fontType: .headline1Bold,
                    color: Color(.labelNeutral)
                )
                .padding(
                    .top,
                    15
                )
                .padding(
                    .bottom,
                    31
                )
                
                Button {
                    //TODO: 되돌리기 API, 새로고침
                    Task {
                        await viewModel.revertCompleteStudy()
                    }
                    viewModel.isRevertBottomSheetPresent = false
                } label: {
                    CustomText(
                        "되돌리기",
                        fontType: .body1Bold,
                        color: Color(.staticWhite)
                    )
                }
                .buttonStyle(SolidButton(true))
                .padding(
                    .bottom,
                    8
                )
                
                Button {
                    viewModel.isRevertBottomSheetPresent.toggle()
                } label: {
                    CustomText(
                        "취소",
                        fontType: .body1Bold,
                        color: Color(.primaryNormal)
                    )
                }
                .buttonStyle(OutlinedLargeButton())
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var filterBottomSheet: some View {
        BottomSheet(
            isShowing: $viewModel.isFilterBottomSheetPresent,
            height: 225) {
                VStack(spacing: 8) {
                    ForEach(
                        FetchTodayStudySortOption.allCases,
                        id: \.self
                    ) { filter in
                        Button {
                            viewModel.sortOption = filter
                            viewModel.isFilterBottomSheetPresent = false
                            Task {
                                await viewModel.fetchData()
                            }
                        } label: {
                            CustomText(
                                filter.buttonTitle,
                                fontType: .body1Bold,
                                color: Color(.labelNeutral)
                            )
                        }
                        .buttonStyle(PressedBottomSheetButtonStyle(isSelected: viewModel.sortOption == filter))
                        // TODO: PressedBottomSheetButtonStyle 만들기
                    }
                }
            }
    }
}

struct TodayStudyDateView: View {
    private let todayDate = Date()
    private let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        
        return calendar
    }()
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 1) {
                CustomText(
                    "\(calendar.component(.month, from: todayDate))",
                    fontType: .title3Bold,
                    color: Color(.labelNormal)
                )
                
                CustomText(
                    "월",
                    fontType: .heading1Bold,
                    color: Color(.labelAlternative)
                )
            }
            
            HStack(spacing: 1) {
                CustomText(
                    "\(calendar.component(.day, from: todayDate))",
                    fontType: .title3Bold,
                    color: Color(.labelNormal)
                )
                
                CustomText(
                    "일",
                    fontType: .heading1Bold,
                    color: Color(.labelAlternative)
                )
            }
            
            CustomText(
                "\(getWeekday())",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
        }
    }
    
    func getWeekday() -> String {
        switch calendar.component(.weekday, from: todayDate) {
        case 1:
            "일"
        case 2:
            "월"
        case 3:
            "화"
        case 4:
            "수"
        case 5:
            "목"
        case 6:
            "금"
        case 7:
            "토"
        default:
            "error"
        }
    }
    
}

struct DelayedStudyButton: View {
    private let count: Int
    
    init(count: Int) {
        self.count = count
    }
    
    var body: some View {
        Button {
            //TODO: 밀린 공부 View 이동
            print("밀린 공부 버튼 Tapped")
        } label: {
            HStack(spacing: 5) {
                CustomText(
                    "밀린 공부 \(count)개 하러 가기",
                    fontType: .body2Bold,
                    color: Color(.primaryNormal)
                )
                
                Image(.chevronRightThickSmall)
            }
            .padding(
                .horizontal,
                20
            )
        }
        .buttonStyle(OutlinedMediumButton())
    }
}

#Preview {
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
            )
        )
    )
}
