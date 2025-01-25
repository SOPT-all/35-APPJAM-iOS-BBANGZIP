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
            .request(
                BbangDefaultRouter.signIn(dto: SignInRequestDTO(code: accessToken)),
                interceptor: CustomInterceptor()
            )
            .serializingDecodable(SignInResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let dto):
            KeychainManager.shared.create(token: .AccessToken, value: dto.data.accessToken)
            KeychainManager.shared.create(token: .RefreshToken, value: dto.data.refreshToken)
            return dto.data.toDomain()
        case .failure(let error):
            throw error
        }
    }
    
    func onboard(
        nickname: String,
        year: Int,
        semester: String,
        subjectName: String
    ) async throws {
        let response = await API.session.request(
            BbangDefaultRouter.onboardingCheck(
                dto: OnboardingRequestDTO(
                    nickname: nickname,
                    year: year,
                    semester: semester,
                    subjectName: subjectName
                )
            ),
            interceptor: CustomInterceptor()
        )
            .serializingDecodable(OnBoardingResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let dto):
            dump(dto)
        case .failure(let error):
            throw error
        }
    }
    
    func logout() async throws {
        let response = await API.session.request(
            BbangDefaultRouter.logout,
            interceptor: CustomInterceptor()
        )
            .serializingDecodable(OnlyCodeResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let dto):
            dump(dto)
        case .failure(let error):
            throw error
        }
    }
    
    func withdraw() async throws {
        let response = await API.session.request(
            BbangDefaultRouter.withdraw,
            interceptor: CustomInterceptor()
        )
            .serializingDecodable(OnlyCodeResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let dto):
            dump(dto)
        case .failure(let error):
            throw error
        }
        
        // TODO: 서버에 저장된 유저의 정보와 유저의 refreshToken 을 제거
    }
    
    func fetchMyPage() async throws -> FetchMyPageResponseData {
        let response = await API.session.request(
            BbangDefaultRouter.fetchMyPage,
            interceptor: CustomInterceptor()
        )
            .serializingDecodable(FetchMyPageResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let dto):
            return dto.data.toDomain()
        case .failure(let error):
            throw error
        }
    }
}
