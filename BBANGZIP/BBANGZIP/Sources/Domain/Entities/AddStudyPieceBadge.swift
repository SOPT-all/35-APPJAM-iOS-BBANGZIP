//
//  AddStudyPieceContent.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

struct AddStudyPieceBadge: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let image: String
    let hashTags: [String]
}
