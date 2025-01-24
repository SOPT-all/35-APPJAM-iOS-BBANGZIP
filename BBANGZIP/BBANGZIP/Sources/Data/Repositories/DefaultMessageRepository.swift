//
//  DefaultMessageRepository.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Alamofire

final class DefaultMessageRepository: MessageRepository {
    
    func motivationMessage(
        subjectId: Int,
        options: String,
        value: String
    ) async throws {
        let response = await API.session.request(
            BbangDefaultRouter.changeName(
                subjectID: subjectId,
                options: options,
                dto: ChangeNameRequestDTO(value: value)
            )
        )
            .serializingDecodable(ChangeNameResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let resultDTO):
            dump(resultDTO)
            return
        case .failure(let error):
            throw error
        }
    }
}
