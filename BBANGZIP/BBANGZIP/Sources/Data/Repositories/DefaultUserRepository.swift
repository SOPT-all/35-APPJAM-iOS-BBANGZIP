//
//  DefaultUserRepository.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Alamofire
import Security

import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth

final class DefaultUserRepository: UserRepository {
    init() {
        KakaoSDK.initSDK(appKey: Secrets.kakao)
    }
    
    func kakaoLogin(completion: @escaping (Result<String, Error>) -> Void) {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk() { oauthToken, error in
                guard let authToken = oauthToken else { return }
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(authToken.accessToken))
                }
            }
        } else {
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                guard let authToken = oauthToken else { return }
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(authToken.accessToken))
                }
            }
        }
    }
    
    func signIn(accessToken: String) async throws -> SignInData {
        let response = await API.session
            .request(BbangDefaultRouter.signIn(dto: SignInRequestDTO(code: accessToken)))
            .responseString { result in
                print("##1##")
                dump(result)
            } 
            .serializingDecodable(SignInResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let dto):
            return dto.data.toDomain()
        case .failure(let error):
            throw error
        }
    }
}
