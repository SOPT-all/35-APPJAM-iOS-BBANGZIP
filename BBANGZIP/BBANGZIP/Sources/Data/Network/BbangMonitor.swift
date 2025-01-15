//
//  BbangMonitor.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

import Alamofire

final class BbangMonitor: EventMonitor {
    let queue = DispatchQueue(label: "myNetworkLogger")
    
    func requestDidFinish(_ request: Request) {
        print("🥨 NETWORK Reqeust LOG")
        print(request.description)
        print(
            "URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
            + "Method: " + (request.request?.httpMethod ?? "") + "\n"
            + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
        )
        print("Authorization: " + (request.request?.headers["Authorization"] ?? ""))
        print("Body: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
    }
    
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
        print("🍰 NETWORK Response LOG")
        print(
            "URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
            + "Result: " + "\(response.result)" + "\n"
            + "StatusCode: " + "\(response.response?.statusCode ?? 0)" + "\n"
            + "Data: \(response.data?.toPrettyPrintedString ?? "")"
        )
    }
}

extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(
            with: self,
            options: []
        ),
              let data = try? JSONSerialization.data(
                withJSONObject: object,
                options: [.prettyPrinted]
              ),
              let prettyPrintedString = NSString(
                data: data,
                encoding: String.Encoding.utf8.rawValue
              )
        else {
            return nil
        }
        
        return prettyPrintedString as String
    }
}
