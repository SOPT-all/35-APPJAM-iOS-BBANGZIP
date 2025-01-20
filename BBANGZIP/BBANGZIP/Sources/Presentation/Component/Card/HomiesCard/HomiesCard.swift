//
//  HomiesCard.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct HomiesCard: View {
    private let state: CardState
    private let profile: SingleProfile
    private let name: String
    
    init(
        state: CardState,
        profile: SingleProfile,
        name: String
    ) {
        self.state = state
        self.profile = profile
        self.name = name
    }
    
    var body: some View {
        HStack(spacing: 0) {
            profile
                .padding(
                    .trailing,
                    16
                )
            
            friendName
            
            Spacer()
            
            Image(.dotsVertical)
                .padding(
                    .horizontal,
                    10
                )
        }
        .frame(maxWidth: .infinity)
        .padding(
            .all,
            16
        )
        .background(backgroundView)
    }
    
    private var friendName: some View {
        HStack(spacing: 3.2) {
            CustomText(
                name,
                fontType: .headline1Bold,
                color: Color(.labelNormal)
            )
            
            CustomText(
                "사장님",
                fontType: .caption2Bold,
                color: Color(.labelAlternative)
            )
        }
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(state.backgroundColor)
            .shadow(
                color: Color(.staticBlack).opacity(0.25),
                radius: 4,
                y: 4
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        state.borderColor,
                        lineWidth: state.borderWidth
                    )
            )
    }
}

#Preview {
    VStack(spacing: 50) {
        HomiesCard(
            state: HomiesCardState.cardDefault,
            profile: SingleProfile(
                size: .medium,
                outlined: true
            ),
            name: "강라리"
        )
        .padding(
            .horizontal,
            20
        )
        
        HomiesCard(
            state: HomiesCardState.selected,
            profile: SingleProfile(
                size: .medium,
                outlined: true
            ),
            name: "강라리"
        )
        .padding(
            .horizontal,
            20
        )
        
        HomiesCard(
            state: HomiesCardState.selectable,
            profile: SingleProfile(
                size: .medium,
                outlined: true
            ),
            name: "강라리"
        )
        .padding(
            .horizontal,
            20
        )
    }
}
