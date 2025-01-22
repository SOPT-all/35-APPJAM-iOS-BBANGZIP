//
//  BalloonWithout.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct BalloonWithout: View {
    
    private let text: String
    private let leftIcon: String?
    private let rightIcon: String?
    private let balloonMode: BalloonMode
    
    init(
        text: String,
        leftIcon: String? = nil,
        rightIcon: String? = nil,
        balloonMode: BalloonMode = .top
    ) {
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.balloonMode = balloonMode
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            if balloonMode == .top {
                topBalloonTip
            }
            
            HStack(spacing: 6) {
                
                if let leftIcon = leftIcon {
                    Image(leftIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 16,
                            height: 16
                        )
                }
                
                CustomText(
                    text,
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
                
                if let rightIcon = rightIcon {
                    Image(rightIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(
                            width: 16,
                            height: 16
                        )
                }
                
            }
            .padding(
                .vertical,
                8
            )
            .padding(.horizontal)

            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.staticWhite))
            )
            .shadow(
                color: Color(.staticBlack).opacity(0.25),
                radius: 4,
                y: 4
            )
            .padding(
                .horizontal
            )
            
            if balloonMode == .bottom {
                bottomBalloonTip
            }
        }
    }
    
    private var topBalloonTip: some View {
        HStack {
            Image(.balloonTip)
                .renderingMode(.template)
                .foregroundStyle(Color(.staticWhite))
                .padding(
                    .leading,
                    24
                )
            
            Spacer()
        }
    }
    
    private var bottomBalloonTip: some View {
        HStack {
            Image(.balloonTip)
                .renderingMode(.template)
                .foregroundStyle(Color(.staticWhite))
                .padding(
                    .leading,
                    24
                )
            
            Spacer()
        }
        .scaleEffect(x: 1, y: -1)
    }

}

//#Preview {
//    Balloon(
//        text: "사장님의 출을 응원해요!",
//        leftIcon: "bubble",
//        rightIcon: "bubble",
//        balloonMode: .top
//    )
//    .padding(.horizontal, 20)
//}

