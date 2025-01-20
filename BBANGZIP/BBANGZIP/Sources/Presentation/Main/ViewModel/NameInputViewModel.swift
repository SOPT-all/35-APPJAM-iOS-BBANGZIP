//
//  NameInputViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class NameInputViewModel: ObservableObject {
    @Published var nickname: String
    @Published var announceState: NicknameTextFieldAlertCase?
    @Published var state: TextFieldState
    
    // TODO: TextField 로직 변경 후 수정 필요
    
    init(
        nickname: String = "",
        announceState: NicknameTextFieldAlertCase? = .alert,
        state: TextFieldState = .defaultState
    ) {
        self.nickname = nickname
        self.announceState = announceState
        self.state = state
    }
}
