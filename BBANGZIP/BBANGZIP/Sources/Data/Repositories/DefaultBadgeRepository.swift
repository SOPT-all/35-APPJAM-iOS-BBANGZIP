//
//  DefaultBadgeRepository.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Alamofire
 
final class DefaultBadgeRepository: BadgeRepository {
    func fetchBadgeDetail(badgeName: String) async throws -> BadgeDetail {
        let response = await API.session.request(BbangDefaultRouter.fetchBadgeDetail(badgeName: badgeName), interceptor: CustomInterceptor())
            .serializingDecodable(BadgeDetailResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let responseDTO):
            return responseDTO.data.toDomain()
        case .failure(let error):
            throw error
        }
    }
    
    func getBadgeList() async throws -> BadgeDictionaryModel {
        let response = await API.session.request(
            BbangDefaultRouter.getBadgeList,
            interceptor: CustomInterceptor()
        )
            .serializingDecodable(GetBadgeListResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let responseDTO):
            return responseDTO.data.toDomain()
        case .failure(let error):
            throw error
        }
    }
    
}
