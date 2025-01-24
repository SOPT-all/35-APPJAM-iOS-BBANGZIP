//
//  AddSubjectResponseDTO.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct AddSubjectResponseDTO: Decodable {
    let code: ResponseCodeDTO
    let message: String?
}

