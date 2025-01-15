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
    
    init(text: String, leftIcon: String? = nil, rightIcon: String? = nil) {
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(.balloonTip)
                    .renderingMode(.template)
                    .foregroundStyle(Color(.backgroundAccent))
                    .padding(.leading, 24)
                
                Spacer()
            }
            
            HStack(spacing: 6) {
                Spacer()
                
                if let leftIcon = leftIcon {
                    Image(leftIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                }
                
                BbangText(text, fontType: .body1, color: Color(.labelNormal))
                
                if let rightIcon = rightIcon {
                    Image(rightIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(.backgroundAccent))
            )
            .shadow(color: Color(.staticBlack).opacity(0.25), radius: 4, y: 4)
        }
    }
}

#Preview {
    Balloon(text: "사장님의 과제 빵점 탈출을 응원해요!", leftIcon: "bubble", rightIcon: "bubble")
        .padding(.horizontal, 20)
}
