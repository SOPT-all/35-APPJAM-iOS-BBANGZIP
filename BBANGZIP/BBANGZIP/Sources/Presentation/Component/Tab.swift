//
//  Tab.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum Tab {
    case subjectManage
    case todo
    case networking
    case mypage
    
    var inActiveImage: Image {
        switch self {
        case .subjectManage:
            Image(.subjectManage)
        case .todo:
            Image(.todo)
        case .networking:
            Image(.networking)
        case .mypage:
            Image(.myPage)
        }
    }
    
    var activeImage: Image {
        switch self {
        case .subjectManage:
            Image(.activeSubjectManage)
        case .todo:
            Image(.activeTodo)
        case .networking:
            Image(.activeNetworking)
        case .mypage:
            Image(.activeMyPage)
        }
    }
    
    var title: String {
        switch self {
        case .subjectManage:
            "과목 관리"
        case .todo:
            "할 일"
        case .networking: 
            "네트워킹"
        case .mypage: 
            "마이페이지"
        }
    }
}
