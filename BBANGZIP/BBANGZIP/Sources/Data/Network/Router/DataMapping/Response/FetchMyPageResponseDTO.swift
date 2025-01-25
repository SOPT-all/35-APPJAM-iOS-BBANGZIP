//
//  FetchMyPageResponseDTO.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/25/25.
//

struct FetchMyPageResponseDTO: Decodable {
    let code: String
    let data: FetchMyPageResponseDataDTO
}

struct FetchMyPageResponseDataDTO: Decodable {
    let level, badgeCounts, reward, maxReward: Int
    let levelDetails: [LevelDetailDTO]
    
    func toDomain() -> FetchMyPageResponseData {
        return FetchMyPageResponseData(
            level: level,
            badgeCounts: badgeCounts,
            reward: reward,
            maxReward: maxReward,
            levelDetails: levelDetails.map { $0.toDomain() }
        )
    }
}

struct LevelDetailDTO: Decodable {
    let level: Int
    let levelName, levelDescription: String
    let levelImage: String
    let levelIsLocked: Bool
    
    func toDomain() -> LevelDetail {
        return LevelDetail(
            level: level,
            levelName: levelName,
            levelDescription: levelDescription,
            levelImage: levelImage,
            levelIsLocked: levelIsLocked
        )
    }
}
