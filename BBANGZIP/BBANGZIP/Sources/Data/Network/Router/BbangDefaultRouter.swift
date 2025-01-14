//
//  BbangDefaultRouter.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

import Alamofire

enum BbangDefaultRouter {
    case kakaoLogin
    case getRefreshToken
    case logout
    case withDraw
    case onBoarding
    case subjectFiltering
    case testSelect(subjectID: Int)
    case addSubject
    case motivationMessage(subjectID: Int, options: String)
    case addStudyScope
    case deleteStudyScope
    case deleteSubject
    case studyCompleteCheck(pieceID: Float)
    case notCompletedCheck(pieceID: Float)
    case sortedTodoList
    case sortedDelayedTodoList
    case addTodoList
    case addTodo
    case addDelayedTodoToToday
    case hideTodo
    case myPageStatus
    case aquireBadge
    case badgeDetail(badgeID: Float)
}

extension BbangDefaultRouter: Router {
    var baseURL: String {
        Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .kakaoLogin:
            return "/api/v1/user/auth/signin"
        case .logout:
            return "/api/v1/user/auth/siginout"
        case .getRefreshToken:
            return "/api/v1/user/auth/re-issue"
        case .withDraw:
            return "/api/v1/user/auth/withdraw"
        case .onBoarding:
            return "/api/v1/user/auth/signup"
        case .subjectFiltering:
            return "/api/v1/subjects/filter"
        case .testSelect(let subjectID):
            return "/api/v1/exam/\(subjectID)"
        case .addSubject:
            return "/api/v1/subjects"
        case .motivationMessage(let subjectID, let options):
            return "/api/v1/subjects/\(subjectID)/\(options)"
        case .addStudyScope:
            return "/api/v1/studies"
        case .deleteStudyScope:
            return "/api/v1/studies/pieces"
        case .deleteSubject:
            return "/api/v1/subject/delete"
        case .studyCompleteCheck(let pieceID):
            return "/api/v1/pieces/\(pieceID)/mark-done"
        case .notCompletedCheck(let pieceID):
            return "/api/v1/pieces/\(pieceID)/mark-undone"
        case .sortedTodoList:
            return "/api/v1/pieces/today"
        case .sortedDelayedTodoList:
            return "/api/v1/pieces/pending"
        case .addTodoList:
            return "/api/v1/pieces/todo"
        case .addTodo:
            return "/api/v1/pieces/assign-to-today"
        case .addDelayedTodoToToday:
            return "/api/v1/pieces/assign-to-today"
        case .hideTodo:
            return "/api/v1/pieces"
        case .myPageStatus:
            return "/api/v1/mypage/status"
        case .aquireBadge:
            return "/api/v1/mypage/badge"
        case .badgeDetail(let badgeID):
            return "/api/v1/badges/\(badgeID)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case
                .kakaoLogin,
                .onBoarding,
                .addSubject,
                .addStudyScope,
                .addTodoList,
                .addTodo,
                .addDelayedTodoToToday:
            return .post
            
        case
                .getRefreshToken,
                .subjectFiltering,
                .testSelect,
                .motivationMessage,
                .sortedTodoList,
                .sortedDelayedTodoList,
                .myPageStatus,
                .aquireBadge,
                .badgeDetail:
            return .get
            
        case
                .logout,
                .withDraw,
                .deleteStudyScope,
                .deleteSubject,
                .hideTodo:
            return .delete
            
        case .studyCompleteCheck,
                .notCompletedCheck:
            return .patch
        }
    }
    
    var headers: [String : String] {
        switch self {
        default:
            [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var parameters: [String : any Sendable] {
        switch self {
        case .kakaoLogin:
            return [:]
        case .getRefreshToken:
            return [:]
        case .logout:
            return [:]
        case .withDraw:
            return [:]
        case .onBoarding:
            return [:]
        case .subjectFiltering:
            return [:]
        case .testSelect(let subjectID):
            return ["subjectID": subjectID]
        case .addSubject:
            return [:]
        case .motivationMessage(let subjectID, let options):
            return ["subjectID": subjectID, "options": options]
        case .addStudyScope:
            return [:]
        case .deleteStudyScope:
            return [:]
        case .deleteSubject:
            return [:]
        case .studyCompleteCheck(let pieceID):
            return ["pieceID": pieceID]
        case .notCompletedCheck(let pieceID):
            return ["pieceID": pieceID]
        case .sortedTodoList:
            return [:]
        case .sortedDelayedTodoList:
            return [:]
        case .addTodoList:
            return [:]
        case .addTodo:
            return [:]
        case .addDelayedTodoToToday:
            return [:]
        case .hideTodo:
            return [:]
        case .myPageStatus:
            return [:]
        case .aquireBadge:
            return [:]
        case .badgeDetail(let badgeID):
            return ["badgeID": badgeID]
        }
    }
    
    var encoding: ParameterEncoding? {
        switch self {
        case .kakaoLogin:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}
