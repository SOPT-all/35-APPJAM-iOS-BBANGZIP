//
//  SubjectDetailView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectDetailView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ZStack {
                    VStack {
                        backgroundView
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 16) {
                        MenuTab(
                            tabNames: [
                                "중간고사",
                                "기말고사"
                            ]
                        )
                        .padding(.top, 125)
                        .padding(.horizontal, 20)
                    }
                }
                
                HStack(spacing: 8) {
                    Chip(type: .daysLeftWithText(24))
                    
                    CustomText(
                        "2025년 5월 13일",
                        fontType: .label1Bold,
                        color: Color(.labelAlternative)
                    )
                }
                
            }
        }
        .navigationBarBackground({
            Color(.backgroundAccent)
        })
    }
    
    var backgroundView: some View {
        HStack {
            CustomText(
                "사장님의 각오 한 마디를 작성해 보세요",
                fontType: .heading2Bold,
                color: Color(.labelAssistive)
            )
            .lineLimit(2)
            .padding(.leading, 24)
            .padding(.trailing, 151)
            
            Spacer()
        }
        .padding(.top, 25)
        .padding(.bottom, 72)
        .background(
            Color(.backgroundAccent)
                .cornerRadius(
                    32,
                    corners: [
                        .bottomLeft,
                        .bottomRight
                    ]
                )
        )
    }
}

#Preview {
    SubjectDetailView()
}
