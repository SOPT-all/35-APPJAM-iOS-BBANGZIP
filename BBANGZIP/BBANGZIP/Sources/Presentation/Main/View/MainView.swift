//
//  MainView.swift
//  Coffee
//
//  Created by 조성민 on 12/22/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        MyPageMainView(level: 1, currentScore: 20, badgeCount: 8)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

