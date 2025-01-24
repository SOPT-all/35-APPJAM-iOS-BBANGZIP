//
//  DefaultStudyPieceRepository.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Alamofire

final class DefaultStudyPieceRepository: StudyPieceRepository {
    
    func addStudyPiece(
        subjectId: Int,
        examName: String,
        studyContents: String,
        examDate: String,
        pieceList: [AddStudyPieceDTO]
    ) async throws  {
        let response = await API.session.request(
            BbangDefaultRouter.addStudyPiece(
                dto: AddStudyPieceRequestDTO(
                    subjectId: subjectId,
                    examName: examName,
                    studyContent: studyContents,
                    examDate: examDate,
                    pieceList: pieceList
                )
            ), interceptor: CustomInterceptor()
        )
            .serializingDecodable(AddStudyPieceResponseDTO.self)
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
