//
//  DefaultExamRepository.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Alamofire

final class DefaultExamRepository: ExamRepository {
    
    func fetchFilterExam(
        subjectId: Int,
        examName: String
    ) async throws -> FilterExamContent {
        let response = await API.session.request(
            BbangDefaultRouter.examFiltering(
                subjectId: subjectId,
                examName: examName
            )
        )
            .serializingDecodable(FilterExamResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let resultDTO):
            dump(resultDTO)
            return resultDTO.data.toDomain()
        case .failure(let error):
            throw error
        }
    }
    
    func deleteStudyPiece(
        pieceIds: [Int]
    ) async throws {
        let response = await API.session.request(
            BbangDefaultRouter.deleteStudyPiece(
                dto: DeleteStudyPieceRequestDTO(
                    pieceIds: pieceIds))
            )
            .serializingDecodable(DeleteSubjectResponseDTO.self)
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
