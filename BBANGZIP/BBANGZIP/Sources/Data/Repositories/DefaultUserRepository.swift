//
//  DefaultUserRepository.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import KakaoSDKUser
import KakaoSDKCommon
import Alamofire

final class DefaultUserRepository: UserRepository {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
        dump(Secrets.kakao)
    }
    
    func kakaoLogin(completion: @escaping (Bool) -> Void) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    _ = oauthToken
                    guard let accessToken = oauthToken?.accessToken else {
                        completion(false)
                        return
                    }
                    KeyChainManager.shared.saveValue(
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
            return
        }
        let result = await session.request(
            BbangDefaultRouter.signup(
                dto: SignInRequestDTO(
                    code: code
                )
            )
        )
            .serializingDecodable(SignInResponseDTO.self).result
        
        switch result {
        case .success(let dto):
            dump(dto)
        case .failure(let error):
            dump(error)
        }
    }
}
