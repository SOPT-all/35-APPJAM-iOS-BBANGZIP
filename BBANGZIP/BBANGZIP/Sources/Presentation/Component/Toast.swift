//
//  Toast.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct Toast: Equatable {
    let firstLineText: String
    let secondLineText: String?
    let type: ToastType
    let bottomPadding: CGFloat
    
    init ( _ firstLineText: String,
           secondLineText: String? = nil,
           type: ToastType = .singleLine,
           startFrom: CGFloat = 16
    ) {
        self.firstLineText = firstLineText
        self.secondLineText = secondLineText
        self.type = type
        self.bottomPadding = startFrom
    }
}

struct ToastView: View {
    private let toast: Toast
    
    init(toast: Toast) {
        self.toast = toast
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomText(
                toast.firstLineText,
                fontType: .label2Bold,
                color: Color(.staticWhite)
            )
            
            if let secondLineText  = toast.secondLineText {
                CustomText(
                    secondLineText,
                    fontType: .label2Bold,
                    color: Color(.staticWhite)
                )
            }
        }
        .padding(.horizontal, toast.type.horizontalInset)
        .padding(.vertical, toast.type.verticalInset)
        .background(
            RoundedRectangle(cornerRadius: toast.type.radius)
                .fill(Color(.labelAlternative))
        )
    }
}
