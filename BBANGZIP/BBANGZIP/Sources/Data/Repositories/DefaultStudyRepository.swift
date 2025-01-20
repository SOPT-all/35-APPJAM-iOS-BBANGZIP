//
//  DefaultStudyRepository.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Alamofire

final class DefaultStudyRepository: StudyRepository {
    func fetchTodayStudy(
        area: TodayStudyArea,
        year: Int,
        semester: Semester,
        sortOption: FetchTodayStudySortOption
    ) async throws -> TodayStudyContent {
        let response = await API.session.request(
            BbangDefaultRouter.fetchSortedTodoList(
                dto: TodayStudyRequestDTO(
                    area: area,
                    year: year,
                    semester: semester,
                    sortOption: sortOption
                )
            )
        )
            .serializingDecodable(TodayStudyResponseDTO.self)
        .response
        
        switch response.result {
        case .success(let resultDTO):
            dump(resultDTO)
            return resultDTO.data.toDomain()
        case .failure(let error):
            throw error
        }
    }
}
