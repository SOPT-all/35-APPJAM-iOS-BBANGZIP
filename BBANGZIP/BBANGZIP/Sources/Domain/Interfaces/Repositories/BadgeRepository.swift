//
//  BadgeRepository.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol BadgeRepository: Sendable {
    func fetchBadgeDetail(badgeName: String) async throws -> BadgeDetail
}
