//
//  Balloon.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct Balloon: View {
    
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
                Spacer()
                
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
                
                Spacer()
            }
            .padding(
                .vertical,
                8
            )
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.staticWhite))
            )
            .shadow(
                color: Color(.staticBlack).opacity(0.25),
                radius: 4,
                y: 4
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

#Preview {
    Balloon(
        text: "사장님의 과제 빵점 탈출을 응원해요!",
        leftIcon: "bubble",
        rightIcon: "bubble",
        balloonMode: .bottom
    )
    .padding(.horizontal, 20)
}
