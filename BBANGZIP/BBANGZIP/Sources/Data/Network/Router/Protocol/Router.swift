//
//  Router.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

import Alamofire

protocol Router {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Sendable] { get }
    var encoding: ParameterEncoding? { get }
}

extension Router {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw RouterError.invalidURL
        }
        var request = URLRequest(url: url)
        request.method = method
        request.headers = HTTPHeaders(headers)
        
        if let encoding = encoding {
            do {
                return try encoding.encode(request, with: parameters)
            } catch {
                throw RouterError.encoding
            }
        }
        
        return request
    }
}
