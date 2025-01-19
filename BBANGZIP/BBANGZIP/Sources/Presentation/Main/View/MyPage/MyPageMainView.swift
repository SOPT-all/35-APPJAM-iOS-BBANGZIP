//
//  MyPageMainView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct MyPageMainView: View {
    @State private var level: Int = 1
    @State private var currentScore: Int = 50
    private let maxScore: Int = 200
    private let title: String = "가판대"
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Color(.backgroundAccent)
                    .cornerRadius(
                        32,
                        corners: [
                            .bottomLeft,
                            .bottomRight
                        ]
                    )
                    .frame(height: 416)
                    .onTapGesture {
                        print("레벨업 상태 화면으로 change 예정")
                    }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Chip(type: .level(level))
                        CustomText(
                            title,
                            fontType: .body1Bold,
                            color: Color(.labelNormal)
                        )
                        
                        Spacer()
                        
                        HStack (spacing:0) {
                            Image(.trophyGray)
                                .scaledToFit()
                                .frame(
                                    width: 24,
                                    height: 24
                                )
                            CustomText(
                                "\(Int(currentScore))/\(Int(maxScore))",
                                fontType: .label2Medium,
                                color: Color(.labelAlternative)
                            )
                        }
                    }
                    
                    ProgressView(value: Double(currentScore), total: Double(maxScore))
                        .progressViewStyle(LinearProgressViewStyle(tint: .black))
                        .frame(height: 8)
                        .background(
                            Capsule()
                                .fill(Color.gray.opacity(0.3))
                        )
                }
                .padding()
                .padding([.leading, .trailing], 67.5)
                .padding(.bottom, 22)
            }
            .edgesIgnoringSafeArea(.all)
            
            Spacer()
        }
    }
}


#Preview {
    MyPageMainView()
}
