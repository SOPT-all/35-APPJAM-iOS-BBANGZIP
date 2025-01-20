//
//  TextFieldTestView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct TextFieldTestView: View {
    @State private var endRange = ""
    @State private var endRangeState: TextFieldState = .defaultState
    @State private var endRangeAnnounceState: StudyRangeTextFieldAlertCase? = .endDefaultCorrect

    var body: some View {
        TextField(
            "종료 페이지",
            text: $endRange
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $endRange,
                style: .studyRange,
                state: endRangeState,
                alertText: endRangeAnnounceState
            )
        )
        .onAppear {
            print("endRangeAnnounceState alertText: \(endRangeAnnounceState?.alertText ?? "nil")")
        }
    }
}

