//
//  TodayStudyView.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct TodayStudyView: View {
    
//    @StateObject private var viewModel: TodayStudyViewModel =
    
    var body: some View {
        ZStack {
            backgroundView
            
            headerView
        }
        .ignoresSafeArea()
    }
    
    var backgroundView: some View {
        VStack {
            Color(.backgroundAccent)
                .cornerRadius(
                    32,
                    corners: [
                        .bottomLeft,
                        .bottomRight
                    ]
                )
                .frame(height: 208)
            
            Spacer()
        }
    }
    
    var headerView: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                HStack {
                    TodayStudyDateView()
                        .padding(
                            .leading,
                            8
                        )
                    
                    Spacer()
                }
                
                HStack {
                    DelayedStudyButton(count: 2) // TODO: 2삭제
                    
                    Spacer()
                }
            }
            .padding(
                .leading,
                24
            )
            .padding(
                .top,
                80
            )
            
            Balloon(
                text: "사장님의 과제 빵점 탈출을 응원해요!",
                leftIcon: Image(.announcement),
                balloonMode: .top
            )
            .padding(
                .horizontal,
                20
            )
            
            Spacer()
        }
    }
}

struct TodayStudyDateView: View {
    private let todayDate = Date()
    private let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko_KR")
        
        return calendar
    }()
    
    var body: some View {
        HStack(spacing: 8) {
            HStack(spacing: 1) {
                CustomText(
                    "\(calendar.component(.month, from: todayDate))",
                    fontType: .title3Bold,
                    color: Color(.labelNormal)
                )
                CustomText(
                    "월",
                    fontType: .heading1Bold,
                    color: Color(.labelAlternative)
                )
            }
            
            HStack(spacing: 1) {
                CustomText(
                    "\(calendar.component(.day, from: todayDate))",
                    fontType: .title3Bold,
                    color: Color(.labelNormal)
                )
                CustomText(
                    "일",
                    fontType: .heading1Bold,
                    color: Color(.labelAlternative)
                )
            }
            
            CustomText(
                "\(getWeekday())",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
        }
    }
    
    func getWeekday() -> String {
        switch calendar.component(.weekday, from: todayDate) {
        case 1:
            "일"
        case 2:
            "월"
        case 3:
            "화"
        case 4:
            "수"
        case 5:
            "목"
        case 6:
            "금"
        case 7:
            "토"
        default:
            "error"
        }
    }
    
}

struct DelayedStudyButton: View {
    private let count: Int
    
    init(count: Int) {
        self.count = count
    }
    
    var body: some View {
        Button {
            print("Aa")
        } label: {
            HStack(spacing: 5) {
                CustomText(
                    "밀린 공부 \(count)개 하러 가기",
                    fontType: .body2Bold,
                    color: Color(.primaryNormal)
                )
                
                Image(.chevronRight)
            }
            .padding(
                .horizontal,
                20
            )
        }
        .buttonStyle(OutlinedMediumButton())
    }
}

#Preview {
    TodayStudyView()
}
