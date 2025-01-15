//
//  API.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

import Alamofire

class API {
    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let apiLogger = BbangMonitor()
        
        return Session(
            configuration: configuration,
            eventMonitors: [apiLogger]
        )
    }()
}

