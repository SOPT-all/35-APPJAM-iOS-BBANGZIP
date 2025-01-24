//
//  TodayStudyView.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI
import Kingfisher

struct TodayStudyView: View {
    @StateObject private var viewModel: TodayStudyViewModel
    @Binding private var isBottomSheetShowing: Bool
    
    init(
        viewModel: TodayStudyViewModel,
        isBottomSheetShowing: Binding<Bool>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isBottomSheetShowing = isBottomSheetShowing
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .task {
                    await viewModel.fetchData()
                }
                .background(Color(.red))
        } else {
            ZStack {
                ScrollView {
                    VStack(spacing: 0) {
                        ZStack {
                            backgroundView
                            
                            headerView
                        }
                        
                        if viewModel.todayCount + viewModel.completeCount == 0 {
                            VStack{
                                Image(.mirunEmpty)
                                    .padding(
                                        .top,
                                        71
                                    )
                                
                                addTodayStudyButton
                                    .padding(
                                        .bottom,
                                        77
                                    )
                            }
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
                    .padding(
                        .bottom,
                        136
                    )
                }
                .ignoresSafeArea(edges: .top)
                
                if viewModel.isDeleteMode && viewModel.isDeleteButtonEnable {
                    deleteButton
                        .padding(
                            .bottom,
                            56
                        )
                }
                
                revertBottomSheet
                
                filterBottomSheet
                
                BottomSheet(
                    isShowing: .constant(!viewModel.badges.isEmpty),
                    height: 530
                ) {
                    VStack(spacing: 0) {
                            CustomText(
                                "배지를 획득했어요!",
                                fontType: .heading2Bold,
                                color: Color(.labelNeutral)
                            )
                            .padding(
                                .top,
                                48
                            )
                            .padding(
                                .bottom,
                                32
                            )
                            
                            TabView {
                                ForEach(viewModel.badges) { badge in
                                    VStack(
                                        alignment: .center,
                                        spacing: 0
                                    ) {
                                        KFImage(URL(string: badge.image))
                                            .resizable()
                                            .cornerRadius(
                                                48,
                                                corners: .allCorners
                                            )
                                            .frame(
                                                width: 160,
                                                height: 160
                                            )
                                            .padding(
                                                .bottom,
                                                8
                                            )
                                        
                                        CustomText(
                                            badge.name,
                                            fontType: .heading1Bold,
                                            color: Color(.labelNormal)
                                        )
                                        .padding(
                                            .bottom,
                                            24
                                        )
                                        
                                        VStack(
                                            alignment: .center,
                                            spacing: 0
                                        ) {
                                            ForEach(badge.hashTags, id: \.self) { hashTag in
                                                CustomText(
                                                    String(hashTag),
                                                    fontType: .body2Bold,
                                                    color: Color(.labelAssistive)
                                                )
                                            }
                                        }
                                    }
                                }
                            }
                            .tabViewStyle(PageTabViewStyle())
                            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            
                            Button {
                                viewModel.badges.removeAll()
                            } label: {
                                CustomText(
                                    "닫기",
                                    fontType: .body1Bold,
                                    color: Color(.staticWhite)
                                )
                            }
                            .buttonStyle(SolidButton())
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
                    .onChange(of: viewModel.badges) { newValue in
                        isBottomSheetShowing = newValue.count > 0
                    }
                
            }
            .task {
                await viewModel.fetchData()
            }
            .toastView(toast: $viewModel.toast)
            // TODO: Badge 여러개 -> Bottom Sheet 여러번 띄우기
            // TODO: NavigationBarBackground 추가
        }
    }
    
    private var backgroundView: some View {
        ZStack {
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
            HStack {
                viewModel.pendingCount > 0 ? Image(.mirunBooks) : Image(.mirunWink)
            }
            .padding(.top, 70)
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
                            delayedStudyButton
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
        }
    }
    
    private var delayedStudyButton: some View {
        NavigationLink {
            AddTodayStudyView(
                viewModel: AddTodayStudyViewModel(
                    fetchAddTodayStudyUseCase: DefaultFetchAddTodayStudyUseCase(
                        repository: DefaultStudyRepository()
                    ),
                    addTodayStudyUseCase: DefaultAddTodayStudyUseCase(
                        repository: DefaultStudyRepository()
                    ),
                    fetchTodayStudyUseCase: DefaultFetchTodayStudyUseCase(
                        studyRepository: DefaultStudyRepository()
                    ),
                    isPending: true
                )
            )
        } label: {
            HStack(spacing: 5) {
                CustomText(
                    "밀린 공부 \(viewModel.pendingCount)개 하러 가기",
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
    
    private var announceTextView: some View {
        HStack {
            VStack(alignment: .leading) {
                CustomText(
                    viewModel.completeAnnounceText,
                    fontType: .label1Bold,
                    color: Color(.labelAlternative)
                )
                .onChange(of: viewModel.completeCount) { newValue in
                    viewModel.reloadCompleteAnnounceText()
                }
                
                CustomText(
                    viewModel.todayAnnounceText,
                    fontType: .title3Bold,
                    color: Color(.labelNormal)
                )
                .onChange(of: viewModel.todayCount) { newValue in
                    viewModel.reloadTodayAnnounceText()
                }
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
                        Task {
                            await viewModel.completeStudy(pieceID: piece.id)
                            piece.state = .complete
                        }
                    } else if piece.state == .complete {
                        if viewModel.isDeleteMode {
                            viewModel.toast = Toast(
                                "이미 완료한 일은 삭제할 수 없어요",
                                startFrom: 80
                            )
                        } else {
                            viewModel.revertTargetPieceID = piece.id
                            viewModel.isRevertBottomSheetPresent = true
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
        NavigationLink {
            AddTodayStudyView(
                viewModel: AddTodayStudyViewModel(
                    fetchAddTodayStudyUseCase: DefaultFetchAddTodayStudyUseCase(
                        repository: DefaultStudyRepository()
                    ),
                    addTodayStudyUseCase: DefaultAddTodayStudyUseCase(
                        repository: DefaultStudyRepository()
                    ),
                    fetchTodayStudyUseCase: DefaultFetchTodayStudyUseCase(
                        studyRepository: DefaultStudyRepository()
                    ),
                    isPending: false
                )
            )
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
        .padding(
            .bottom,
            77
        )
    }
    
    private var deleteButton: some View {
        VStack {
            Spacer()
            
            Button {
                Task {
                    await viewModel.removeTodayStudyPieces()
                }
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
                    Task {
                        await viewModel.revertCompleteStudy()
                    }
                    viewModel.isRevertBottomSheetPresent = false
                    viewModel.toast = Toast(
                        "미완료 상태로 되돌렸어요!",
                        startFrom: 76
                    )
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
                    viewModel.isRevertBottomSheetPresent = false
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
        .onChange(of: viewModel.isRevertBottomSheetPresent) { newValue in
            isBottomSheetShowing = newValue
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
                            viewModel.toast = Toast(
                                "\(filter.buttonTitle)으로 정렬했어요",
                                startFrom: 76
                            )
                        } label: {
                            HStack {
                                Spacer()
                                
                                CustomText(
                                    filter.buttonTitle,
                                    fontType: .body1Bold,
                                    color: Color(.labelNeutral)
                                )
                                .padding(
                                    .vertical,
                                    8
                                )
                                
                                Spacer()
                            }
                        }
                        .padding(
                            .horizontal,
                            20
                        )
                        .buttonStyle(PressedBottomSheetButtonStyle(isSelected: viewModel.sortOption == filter))
                    }
                }
                .padding(
                    .top,
                    24
                )
            }
            .onChange(of: viewModel.isFilterBottomSheetPresent) { newValue in
                isBottomSheetShowing = newValue
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
