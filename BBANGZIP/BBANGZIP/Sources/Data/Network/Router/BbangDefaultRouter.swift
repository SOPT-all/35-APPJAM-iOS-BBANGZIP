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
    case signup(dto: SignInRequestDTO)
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
        case .signup:
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
                .signup,
                .getRefreshToken,
                .onBoarding,
                .addSubject,
                .addStudyScope,
                .addTodoList,
                .addTodo,
                .addDelayedTodoToToday:
            return .post
            
        case
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
    
    var headers: [String : String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var parameters: [String : any Sendable]? {
        switch self {
        case .signup(let dto):
            return dto.asDictionary()
        case .testSelect(let subjectID):
            return ["subjectID": subjectID]
        case .motivationMessage(
            let subjectID,
            let options
        ):
            return [
                "subjectID": subjectID,
                "options": options
            ]
        case .studyCompleteCheck(let pieceID), .notCompletedCheck(let pieceID):
            return ["pieceID": pieceID]
        case .badgeDetail(let badgeID):
            return ["badgeID": badgeID]
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding? {
        switch self {
        case .signup:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
}

extension Encodable {
    func asDictionary() -> [String : any Sendable]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
        as? [String : any Sendable]
    }
}
