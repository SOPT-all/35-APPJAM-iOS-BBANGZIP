//
//  CustomNavigationBar.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomNavigationBarView: View {
    @SwiftUI.Environment(\.dismiss) var dismiss
    let showBackButton: Bool
    let showMenu: Bool
    let title: String
    let backgroundColor: Color?
    
    init(showBackButton: Bool, showMenu: Bool, title: String, backgroundColor: Color) {
        self.showBackButton = showBackButton
        self.showMenu = showMenu
        self.title = title
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea(edges: .top)
            
            HStack {
                
                if showBackButton {
                    backButton
                } else {
                    ZStack {
                        
                    }
                    .frame(
                        width: 24,
                        height: 24
                    )
                }
                
                Spacer()
                
                CustomText(
                    title,
                    fontType: .headline1Bold,
                    color: Color(.labelNeutral)
                )
                
                Spacer()
                
                if showMenu {
                    kebabButton
                } else {
                    ZStack {
                        
                    }
                    .frame(
                        width: 24,
                        height: 24
                    )
                }
            }
            .padding(.horizontal)
            
        }
        .frame(height: 56)
    }
}

extension CustomNavigationBarView {
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(.chevronLeftThickSmall)
                .resizable()
                .frame(
                    width: 24,
                    height: 24
                )
        }
    }
    
    private var kebabButton: some View {
        Button(action: {
            
        }) {
            Image(.dotsVertical)
                .resizable()
                .frame(
                    width: 24,
                    height: 24
                )
        }
    }
}
