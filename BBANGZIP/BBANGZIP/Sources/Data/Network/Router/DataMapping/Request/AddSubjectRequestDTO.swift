//
//  AddSubjectRequestDTO.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct AddSubjectRequestDTO: Encodable {
    let year: Int
    let semester: Semester
    let subjectName: String
}
