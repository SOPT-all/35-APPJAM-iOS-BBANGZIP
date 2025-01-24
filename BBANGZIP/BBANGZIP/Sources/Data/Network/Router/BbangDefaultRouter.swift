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
    case signup(dto: signInRequestDTO)
    case getRefreshToken
    case logout
    case withDraw
    case onBoarding
    case testSelect(subjectID: Int)
    case motivationMessage(subjectID: Int, options: String)
    case addStudyScope
    case deleteStudyScope
    case studyCompleteCheck(pieceID: Float)
    case notCompletedCheck(pieceID: Float)
    case sortedDelayedTodoList
    case addTodoList
    case addTodo
    case addDelayedTodoToToday
    case hideTodo
    case myPageStatus
    case aquireBadge
    case badgeDetail(badgeID: Float)
    
    //성민
    case fetchSortedTodoList(dto: TodayStudyRequestDTO)
    case completeStudy(pieceID: Int, dto: StudyCompleteRequestDTO)
    case revertCompleteStudy(pieceID: Int, dto: StudyCompleteRequestDTO)
    case removeTodayStudy(dto: RemoveTodayStudyDTO)
    case fetchAddTodayStudy(dto: FetchAddTodayStudyRequestDTO)
    case addTodayStudy(dto: AddTodayStudyRequestDTO)
    
    //여경
    case fetchBadgeDetail(badgeName: String)
    
    //유빈
    case examFiltering(subjectId: Int, examName: String)
    case fetchSubject(dto: FetchSubjectRequestDTO)
    case addSubject(dto: AddSubjectRequestDTO)
    case deleteSubject(dto: DeleteSubjectRequestDTO)
    
}

extension BbangDefaultRouter: Router {
    var baseURL: String {
        Environment.baseURL // 수정 필요
    }
    
    var path: String {
        switch self {
        case .signup(let signInRequest):
            return "/api/v1/user/auth/signin"
        case .logout:
            return "/api/v1/user/auth/siginout"
        case .getRefreshToken:
            return "/api/v1/user/auth/re-issue"
        case .withDraw:
            return "/api/v1/user/auth/withdraw"
        case .onBoarding:
            return "/api/v1/user/auth/signup"
        case .examFiltering(let subjectId, let examName):
            return "/api/v1/exams/\(subjectId)/\(examName)"
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
            return "/api/v1/subjects"
        case .studyCompleteCheck(let pieceID):
            return "/api/v1/pieces/\(pieceID)/mark-done"
        case .notCompletedCheck(let pieceID):
            return "/api/v1/pieces/\(pieceID)/mark-undone"
        case .fetchSortedTodoList:
            return "/api/v1/pieces/today/orders"
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
        case .completeStudy(let pieceID, _):
            return "/api/v1/pieces/\(pieceID)/mark-done"
        case .revertCompleteStudy(let pieceID, _):
            return "/api/v1/pieces/\(pieceID)/mark-undone"
        case .removeTodayStudy:
            return "/api/v1/pieces/hide"
        case .fetchBadgeDetail(let badgeName):
            return "/api/v1/mypage/badges/\(badgeName)"
        case .fetchAddTodayStudy:
            return "/api/v1/pieces/todo"
        case .fetchSubject:
            return "/api/v1/subjects/filter"
        case .addTodayStudy:
            return "/api/v1/pieces/assign-to-today"
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
                .addDelayedTodoToToday,
                .completeStudy,
                .revertCompleteStudy,
                .removeTodayStudy,
                .addTodayStudy:
            return .post
            
        case
                .examFiltering,
                .testSelect,
                .motivationMessage,
                .fetchSortedTodoList,
                .sortedDelayedTodoList,
                .myPageStatus,
                .aquireBadge,
                .badgeDetail,
                .fetchBadgeDetail,
                .fetchAddTodayStudy,
                .fetchSubject:
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
        case .signup(let signInRequest):
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(signInRequest.authorization)"
            ]
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer"
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
        case .fetchSortedTodoList(let dto):
            return dto.asDictionary()
        case .completeStudy(_, let dto):
            return dto.asDictionary()
        case .revertCompleteStudy(_, let dto):
            return dto.asDictionary()
        case .removeTodayStudy(let dto):
            return dto.asDictionary()
        case .fetchBadgeDetail:
            return [:]
        case .fetchAddTodayStudy(let dto):
            return dto.asDictionary()
        case .examFiltering(_, _):
            return nil
        case .fetchSubject(let dto):
            return dto.asDictionary()
        case .addSubject(let dto):
            return dto.asDictionary()
        case .deleteSubject(let dto):
            return dto.asDictionary()
        case .addTodayStudy(let dto):
            return dto.asDictionary()
        default:
            return nil
        }
    }
    
    var encoding: ParameterEncoding? {
        switch self {
        case .signup, .fetchSortedTodoList, .fetchAddTodayStudy, .fetchSubject:
            return URLEncoding.default
        case .fetchBadgeDetail, .examFiltering:
            return nil
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
