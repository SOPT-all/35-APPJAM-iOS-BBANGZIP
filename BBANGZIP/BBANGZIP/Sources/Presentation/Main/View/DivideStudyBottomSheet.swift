//
//  DivideBottomSheet.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct DivideStudyBottomSheet: View {
    @Binding private var isPresented: Bool
    
    private let pieces = Array(1...6)
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        CustomText(
            "몇 조각으로 쪼개서 공부할까요?",
            fontType: .headline1Bold,
            color: Color(.labelNeutral)
        )
        .padding(
            .vertical,
            39
        )
        
        VStack {
            ForEach(pieces, id: \.self) { num in
                CustomText(
                    "\(num)조각",
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
                .padding(
                    .vertical,
                    8
                )
            }
        }
        .padding(
            .bottom,
            24
        )
    }
}

#Preview {
    let isPresented = Binding.constant(true)
    
    DivideStudyBottomSheet(isPresented: isPresented)
}
