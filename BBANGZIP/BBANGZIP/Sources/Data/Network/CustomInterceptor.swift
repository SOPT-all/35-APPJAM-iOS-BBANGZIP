//
//  CustomInterceptor.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

import Alamofire

final class CustomInterceptor: RequestInterceptor {
    func adapt(
        _ urlRequest: URLRequest,
        for session: Session,
        completion: @escaping (Result<URLRequest, Error>) -> Void
    ) {
        var request = urlRequest
        guard !(request.url?.absoluteString.contains("signIn"))! else {
            return completion(.success(request))
        }
        request.headers.add(.contentType("application/json"))
        if let accessToken = KeychainManager.shared.read(token: .AccessToken) {
            request.headers.add(.authorization(bearerToken: accessToken))
        } else if let refreshToken = KeychainManager.shared.read(token: .RefreshToken) {
            request.headers.add(.authorization(bearerToken: refreshToken))
        }
        completion(.success(request))
    }
}
