//
//  FetchMyPageResponseData.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/25/25.
//

struct FetchMyPageResponseData {
    let level, badgeCounts, reward, maxReward: Int
    let levelDetails: [LevelDetail]
}

struct LevelDetail: Hashable {
    let level: Int
    let levelName, levelDescription: String
    let levelImage: String
    let levelIsLocked: Bool
}
