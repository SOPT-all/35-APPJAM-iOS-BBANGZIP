//
//  ChangeSemesterButton.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ChangeSemesterButton: View {
    @Binding private var isShowingBottomSheet: Bool
    
    init(isShowingBottomSheet: Binding<Bool>) {
        self._isShowingBottomSheet = isShowingBottomSheet
    }
    
    var body: some View {
        Button {
            isShowingBottomSheet = true
        } label: {
            HStack(spacing: 4) {
                CustomText(
                    "2025년 1학기",
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
                
                Image(.chevronDown)
                    .renderingMode(.template)
                    .resizable()
                    .frame(
                        width: 20,
                        height: 20
                    )
                    .foregroundStyle(Color(.labelNormal))
            }
        }
    }
}
