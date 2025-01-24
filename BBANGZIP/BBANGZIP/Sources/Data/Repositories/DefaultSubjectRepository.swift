//
//  DefaultSubjectRepository.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Alamofire

final class DefaultSubjectRepository: SubjectRepository {
    func fetchSubject(
        year: Int,
        semester: Semester
    ) async throws -> SubjectContent {
        let response = await API.session.request(
            BbangDefaultRouter.fetchSubject(
                dto: FetchSubjectRequestDTO(
                    year: year,
                    semester: semester
                )
            )
        )
            .serializingDecodable(FetchSubjectResponseDTO.self)
            .response
        
        switch response.result {
        case .success(let resultDTO):
            dump(resultDTO)
            return resultDTO.data.toDomain()
        case .failure(let error):
            throw error
        }
    }
    
    func addSubject(
        year: Int,
        semester: Semester,
        subjectName: String
    ) async throws  {
        let response = await API.session.request(
            BbangDefaultRouter.addSubject(
                dto: AddSubjectRequestDTO(
                    year: year,
                    semester: semester,
                    subjectName: subjectName
                )
            )
        )
        .serializingDecodable(AddSubjectResponseDTO.self)
        .response
        
        switch response.result {
        case .success(let resultDTO):
            dump(resultDTO)
            return
        case .failure(let error):
            throw error
        }
    }
    
    func deleteSubject(
        year: Int,
        semester: Semester,
        subjectIds: [Int]
    ) async throws {
        let response = await API.session.request(
            BbangDefaultRouter.deleteSubject(
                dto: DeleteSubjectRequestDTO(
                    year: year,
                    semester: semester,
                    subjectIds: subjectIds
                )
            )
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
