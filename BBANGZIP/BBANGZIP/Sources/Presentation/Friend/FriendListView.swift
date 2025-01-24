//
//  FriendListView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/25/25.
//

import SwiftUI

struct FriendListView: View {
    @State var isLoading: Bool = true
    @State var friendName: String = ""
    @State var friendAnnounceState: FriendTextFieldAlertCase = .alert
    @State var friendState: TextFieldState = .defaultState
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    Image(.userPlus)
                        .renderingMode(.template)
                        .foregroundStyle(Color(.materialDimmer))
                        .padding(
                            .all,
                            16
                        )
                    
                    Spacer()
                    
                    Image(.bell)
                        .renderingMode(.template)
                        .foregroundStyle(Color(.materialDimmer))
                        .padding(
                            .all,
                            16
                        )
                }
                .background(Color(.backgroundAccent))
                
                ZStack {
                    ScrollView {
                        ZStack {
                            VStack {
                                Color(.backgroundAccent)
                                    .frame(height: 153)
                                    .cornerRadius(
                                        32,
                                        corners: [
                                            .bottomLeft,
                                            .bottomRight
                                        ]
                                    )
                                    .ignoresSafeArea(
                                        .all,
                                        edges: .top
                                    )
                                
                                Spacer()
                            }
                            
                            VStack(spacing: 0) {
                                titleView
                                    .padding(
                                        .top,
                                        17
                                    )
                                
                                MenuTab(
                                    tabNames: [
                                        "전체",
                                        "그룹",
                                        "신청대기"
                                    ]
                                )
                                .padding(
                                    .top,
                                    40
                                )
                                
                                searchTextField
                                    .padding(
                                        .top,
                                        48
                                    )
                                
                                HStack(spacing: 0) {
                                    totalFriendInfo
                                    
                                    Spacer()
                                    
                                    sortCriteria
                                }
                                .padding(
                                    .top,
                                    20
                                )
                                
                                friendCardList
                                    .padding(
                                        .top,
                                        24
                                    )
                            }
                            .padding(
                                .horizontal,
                                20
                            )
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
            }
        }
    }
    
    private var titleView: some View {
        HStack {
            CustomText(
                "이웃 사장님들은 어떻게 공부하고 있을까요?",
                fontType: .title3Bold,
                color: Color(.labelNeutral)
            )
            
            Spacer()
        }
    }
    
    private var searchTextField: some View {
        TextField(
            "이웃 사장님의 이름을 검색해보세요",
            text: $friendName
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $friendName,
                style: .friend,
                state: friendState,
                alertText: friendAnnounceState
            )
        )
    }
    
    private var totalFriendInfo: some View {
        CustomText(
            "총 7명의 사장님을 알고있어요",
            fontType: .label1Bold,
            color: Color(.labelAlternative)
        )
    }
    
    private var sortCriteria: some View {
        HStack(spacing: 4) {
            CustomText(
                "이름순",
                fontType: .label1Bold,
                color: Color(.labelAlternative)
            )
            
            Image(.chevronDown)
                .resizable()
                .frame(width: 16, height: 16)
        }
    }
    
    private var friendCardList: some View {
        VStack(spacing: 12) {
            HomiesImageCard(
                state: HomiesCardState.cardDefault,
                profile: Image(.friendProfile),
                name: "강라리"
            )
            
            HomiesImageCard(
                state: HomiesCardState.cardDefault,
                profile: Image(.friendProfile),
                name: "강라리"
            )
            
            HomiesImageCard(
                state: HomiesCardState.cardDefault,
                profile: Image(.friendProfile),
                name: "강라리"
            )
            
            HomiesImageCard(
                state: HomiesCardState.cardDefault,
                profile: Image(.friendProfile),
                name: "강라리"
            )
            
            HomiesImageCard(
                state: HomiesCardState.cardDefault,
                profile: Image(.friendProfile),
                name: "강라리"
            )
            
            HomiesImageCard(
                state: HomiesCardState.cardDefault,
                profile: Image(.friendProfile),
                name: "강라리"
            )
        }
    }
}

#Preview {
    FriendListView()
}
