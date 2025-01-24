//
//  MessageRepository.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol MessageRepository: Sendable {
    func motivationMessage(subjectId: Int, options: String, value: String) async throws
}
