//
//  TodayStudyContent.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct TodayStudyContent {
    let todayCount: Int
    let completeCount: Int
    let pendingCount: Int
    let todoPiecesList: [StudyPiece]
    
    var completeAnnounceText: String {
        if pendingCount > 0 {
            if completeCount > 0 {
                "벌써 \(completeCount)개나 완료하셨네요!"
            } else {
                "아직 완료된 할일이 없어요!"
            }
        } else {
            "사장님 퇴근 준비 완료"
        }
    }
    
    var pendingAnnounceText: String {
        if pendingCount > 0 {
            "총 \(pendingCount)개의 공부가 남았어요"
        } else {
            "오늘의 공부를 모두 끝냈어요!"
        }
    }
}
