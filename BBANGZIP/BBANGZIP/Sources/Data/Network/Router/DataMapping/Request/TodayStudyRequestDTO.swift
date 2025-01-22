//
//  TodayStudyRequestDTO.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct TodayStudyRequestDTO: Encodable {
    let area: TodayStudyArea
    let year: Int
    let semester: Semester
    let sortOption: FetchTodayStudySortOption
}
