//
//  LoginView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: KakaoLoginViewModel
    @Binding private var isLogin: Bool
    @Binding private var isOnboardingComplete: Bool
    
    init(viewModel: KakaoLoginViewModel, isLogin: Binding<Bool>, isOnboardingComplete: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isLogin = isLogin
        _isOnboardingComplete = isOnboardingComplete
    }
    
    var body: some View {
        VStack (spacing: 0) {
            titleView
            
            onBoardingSectionView
            
            loginSection
            
            Spacer()
        }
        .onChange(of: viewModel.isLogin) { newValue in
            isLogin = newValue
        }
        .onChange(of: viewModel.isOnboardingComplete) { newValue in
            isOnboardingComplete = newValue
        }
    }
    
    var titleView: some View {
        VStack {
            HStack {
                CustomText(
                    "제 과제 빵점 사장님은\n이번 학기 백점!",
                    fontType: .title2Bold,
                    color: Color(.labelNormal)
                )
                
                Spacer()
                
            }
            .padding(.leading, 22)
            .background(Color(.backgroundAccent))
        }.padding(.top, 50)
        .frame(
            height: 196
        )
        .background(Color(.backgroundAccent))
    }
    
    private var onBoardingSectionView: some View {
            TabView {
                
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: 336)
            .background(Color(.backgroundAccent))
    }
    
    private var loginSection: some View {
        VStack (spacing: 0) {
            Image(.loginBalloon)
                .padding(.bottom, 5)
            
            Button(action: {
                print("카카오 로그인 버튼 클릭")
                viewModel.kakaoLogin()
            }) {
                HStack (spacing:0) {
                    Image(.kakao)
                        .resizable()
                        .frame(
                            width: 24,
                            height: 24
                        )
                        .padding(.trailing, 8)
                    
                    CustomText(
                        "카카오로 로그인하기",
                        fontType: .body1Bold,
                        color: Color(
                            .kakaoLabel
                        )
                    )
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(.kakaoContainer))
                .foregroundColor(.black)
                .cornerRadius(24)
            }
            .padding(
                .horizontal,
                20
            )
            
        }
        .frame(height: 80)
        .padding(
            .top,
            117
        )
    }
    
}

//#Preview {
//    LoginView()
//}
