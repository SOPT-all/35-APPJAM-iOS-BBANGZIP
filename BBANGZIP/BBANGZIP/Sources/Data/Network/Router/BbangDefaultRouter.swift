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
    //성민
    case fetchSortedTodoList(dto: TodayStudyRequestDTO)
    case completeStudy(pieceID: Int, dto: StudyCompleteRequestDTO)
    case revertCompleteStudy(pieceID: Int, dto: StudyCompleteRequestDTO)
    case removeTodayStudy(dto: RemoveTodayStudyDTO)
    case fetchAddTodayStudy(dto: FetchAddTodayStudyRequestDTO)
    case addTodayStudy(dto: AddTodayStudyRequestDTO)
    
    //여경
    case fetchBadgeDetail(badgeName: String)
    case signIn(dto: SignInRequestDTO)
    case getBadgeList
    case onboardingCheck(dto: OnboardingRequestDTO)
    
    //유빈
    case examFiltering(subjectId: Int, examName: String)
    case fetchSubject(dto: FetchSubjectRequestDTO)
    case addSubject(dto: AddSubjectRequestDTO)
    case deleteSubject(dto: DeleteSubjectRequestDTO)
    case changeName(subjectID: Int, options: String, dto: ChangeNameRequestDTO)
    case deleteStudyPiece(dto: DeleteStudyPieceRequestDTO)
    
}

extension BbangDefaultRouter: Router {
    var baseURL: String {
        Environment.baseURL
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/api/v1/user/auth/signin"
        case .onboardingCheck:
            return "/api/v1/user/auth/signup"
        case .examFiltering(let subjectId, let examName):
            return "/api/v1/exams/\(subjectId)/\(examName)"
        case .addSubject:
            return "/api/v1/subjects"
        case .changeName(let subjectId, let options, _):
            return "/api/v1/subjects/\(subjectId)/\(options)"
        case .deleteStudyPiece:
            return "/api/v1/studies/pieces"
        case .deleteSubject:
            return "/api/v1/subjects"
        case .fetchSortedTodoList:
            return "/api/v1/pieces/today/orders"
        case .getBadgeList:
            return "/api/v1/mypage/badges"
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
                .signIn,
                .addSubject,
                .completeStudy,
                .revertCompleteStudy,
                .removeTodayStudy,
                .addTodayStudy:
            return .post
            
        case
                .examFiltering,
                .fetchSortedTodoList,
                .fetchBadgeDetail,
                .fetchAddTodayStudy,
                .fetchSubject,
                .getBadgeList:
            return .get
            
        case
                .deleteStudyPiece,
                .deleteSubject:
            return .delete
            
        case
                .onboardingCheck:
            return .patch
            
        case
                .changeName:
            return .put
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
    var parameters: [String : any Sendable]? {
        switch self {
        case .signIn(let dto):
            return dto.asDictionary()
        case .changeName(_, _, let dto):
            return dto.asDictionary()
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
        case .getBadgeList:
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
        case .deleteStudyPiece(let dto):
            return dto.asDictionary()
        case .addTodayStudy(let dto):
            return dto.asDictionary()
        case .onboardingCheck(let dto):
            return dto.asDictionary()
        }
    }
    
    var encoding: ParameterEncoding? {
        switch self {
        case
                .signIn,
                .fetchSortedTodoList,
                .fetchSubject,
                .fetchAddTodayStudy:
            return URLEncoding.queryString
        case
                .fetchBadgeDetail,
                .examFiltering,
                .getBadgeList:
            return nil
        case
                
                .completeStudy,
                .revertCompleteStudy,
                .removeTodayStudy,
                .addTodayStudy,
                .onboardingCheck,
                .addSubject,
                .deleteSubject,
                .changeName,
                .deleteStudyPiece:
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
