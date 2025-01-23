//
//  MenuTab.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//
import SwiftUI

struct MenuTab: View {
    private let tabNames: [String]
    @State private var selectedTab: String
    var onTabChanged: ((String) -> Void)?
    
    init(
        tabNames: [String],
        onTabChanged: ((String) -> Void)? = nil
    ) {
        self.tabNames = tabNames
        _selectedTab = State(initialValue: tabNames.first ?? "")
        self.onTabChanged = onTabChanged
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(Color(.staticWhite))
                .frame(height: 64)
            HStack {
                Spacer()
                ForEach(tabNames, id: \.self) { tabName in
                    Button(action: {
                        selectedTab = tabName
                        onTabChanged?(tabName)
                    }) {
                        VStack(spacing: 8) {
                            CustomText(
                                tabName,
                                fontType: .body1Bold,
                                color: selectedTab == tabName ? Color(.labelNormal) : Color(.labelAssistive)
                            )
                            if selectedTab == tabName {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color(.labelNormal))
                                    .frame(
                                        width: calculateTextWidth(tabName),
                                        height: 2
                                    )
                            } else {
                                Spacer().frame(height: 2)
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
        }
        .customShadow(.emphasize)
    }
    
    private func calculateTextWidth(_ text: String) -> CGFloat {
        let uiFont = UIFont(
            name: "Pretendard-Bold",
            size: CustomFont.body1Bold.size
        ) ?? UIFont.systemFont(
            ofSize: CustomFont.body1Bold.size,
            weight: .bold
        )
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: uiFont,
            .kern: CustomFont.body1Bold.letterSpacing
        ]
        let size = text.size(withAttributes: attributes)
        return size.width - 16
    }
}

#Preview {
    MenuTab(
        tabNames: ["중간고사", "기말고사"]
    )
}
