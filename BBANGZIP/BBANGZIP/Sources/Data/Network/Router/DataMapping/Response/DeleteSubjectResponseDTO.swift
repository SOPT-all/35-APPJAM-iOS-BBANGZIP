//
//  DeleteSubjectResponseDTO.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct DeleteSubjectResponseDTO: Decodable {
    let code: ResponseCodeDTO
    let message: String?
    let data: [String]?
}
