//
//  DefaultUserRepository.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Alamofire
import Security

import KakaoSDKUser
import KakaoSDKCommon


final class DefaultUserRepository: UserRepository {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
        dump(Secrets.kakao)
    }
    
    func kakaoLogin(completion: @escaping (Bool) -> Void) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                if let error = error {
                    print(error)
                    completion(false)
                } else {
                    print("loginWithKakaoTalk() 성공")
                    
                    guard let accessToken = oauthToken?.accessToken else {
                        completion(false)
                        return
                    }
                    
                    let status = KeyChainManager.shared.saveValue(
                        token: accessToken,
                        type: .AccessToken
                    )
                    completion(true)
                }
            }
        } else {
            completion(false)
        }
    }
    
    func registerKakaoToken() async {
        guard let code = KeyChainManager.shared.searchValue() else {
            print("Keychain에서 코드를 찾을 수 없습니다.")
            return
        }
        
        do {
            let result = try await session.request(
                BbangDefaultRouter.signup(
                    dto: SignInRequestDTO(code: code)
                )
            )
                .serializingDecodable(SignInResponseDTO.self).value
            
            print("회원가입 성공: \(result)")
        } catch {
            if let afError = error.asAFError {
                print("Alamofire 에러: \(afError)")
            } else if let decodingError = error as? DecodingError {
                print("디코딩 에러: \(decodingError)")
            } else {
                print("알 수 없는 에러: \(error)")
            }
        }
    }
}
