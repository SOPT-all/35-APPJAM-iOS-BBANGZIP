//
//  MainView.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//
import SwiftUI
import KakaoSDKUser
import KakaoSDKCommon

struct MainView: View {
    
    @State private var viewModel = MainViewModel(
        useCase: DefaultKakaoLoginUseCase(
            repository: DefaultUserRepository()
        )
    )
    
    init() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                NavigationLink(destination: TestView()) {
                    Text("Go to TestView")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    print("카카오 로그인 버튼 클릭")
                    viewModel.kakaoLogin()
//                    if (UserApi.isKakaoTalkLoginAvailable()) {
//                        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
//                            if let error = error {
//                                print(error)
//                            }
//                            else {
//                                print("loginWithKakaoTalk() success.")
//                                
//                                _ = oauthToken
//                            }
//                        }
//                    }
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
                .padding(.horizontal,20)
                
                Spacer()
            }
            .navigationTitle("Main View")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
