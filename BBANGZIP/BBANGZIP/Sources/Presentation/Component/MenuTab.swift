//
//  MenuTab.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct MenuTab: View {
    private let tabNames: [String]
    
    init(tabNames: [String]) {
        self.tabNames = tabNames
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(.staticWhite))
                .frame(
                    width: .infinity,
                    height: 64
                )
                .shadow(// TODO: Shadow 변경 후
                    color: Color(.staticBlack).opacity(0.25),
                    radius: 4,
                    y: 4
                )
            
            HStack {
                
                Spacer()
                ForEach(tabNames, id: \.self) { tabName in
                    VStack {
                        CustomText(
                            tabName,
                            fontType: .body1Bold,
                            color: Color(.labelNormal)
                        )
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.labelNormal))
                            .frame(height: 2)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            Spacer()
        }
    }
}

#Preview {
    MenuTab(tabNames: [
        "중간고사",
        "기말고사"
    ])
}
