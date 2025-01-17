//
//  TabButton.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomTabButton: View {
    private(set) var tab: Tab
    @Binding var selected: Tab
    
    init(
        tab: Tab,
        selected: Binding<Tab>
    ) {
        self.tab = tab
        self._selected = selected
    }
    
    var body: some View {
        Button {
            selected = tab
        } label: {
            VStack(
                alignment: .center,
                spacing: 4
            ) {
                (selected == tab ? tab.activeImage : tab.inActiveImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .padding(
                        .horizontal,
                        24
                    )
                CustomText(
                    tab.title,
                    fontType: .caption1Bold,
                    color: selected == tab ? Color(.labelNormal) : Color(.labelAssistive)
                )
            }
        }
    }
}
