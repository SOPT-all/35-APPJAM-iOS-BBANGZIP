//
//  BeforeNameInputView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct BeforeNameInputView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                nextButton
            }
        }
    }
    
    private var nextButton: some View {
        NavigationLink("다음으로") {
            NameInputView()
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronLeftThickSmall)
            )
        )
    }

}

#Preview {
    BeforeNameInputView()
}
