//
//  BottomSheet.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct BottomSheet<Content: View>: View {
    @Binding private var isShowing: Bool
    private let height: Int
    private let content: () -> Content
    @State private var currentHeight: CGFloat
    
    init(
        isShowing: Binding<Bool>,
        height: Int,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isShowing = isShowing
        self.height = height
        self.content = content
        self._currentHeight = State(initialValue: CGFloat(height))
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation { isShowing.toggle() }
                    }
                
                VStack {
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color(.interactionInactive))
                        .frame(
                            width: 36,
                            height: 5
                        )
                        .padding(
                            .top,
                            8
                        )
                    
                    content()
                    
                    Spacer()
                }
                .frame(height: CGFloat(height))
                .frame(maxWidth: .infinity)
                .background(Color(.backgroundNormal))
                .cornerRadius(
                    48,
                    corners: [
                        .topLeft,
                        .topRight
                    ]
                )
                .shadow(
                    color: Color.black.opacity(0.2),
                    radius: 4,
                    x: 0,
                    y: -4
                )
                .transition(.move(edge: .bottom))
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .bottom
        )
        .ignoresSafeArea()
        .animation(
            .easeInOut,
            value: isShowing
        )
    }
}

extension View {
    func bottomSheet<Content: View>(
        isShowing: Binding<Bool>,
        height: Int,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        BottomSheet(
            isShowing: isShowing,
            height: height,
            content: content
        )
    }
}

extension View {
    func cornerRadius(
        _ radius: CGFloat,
        corners: UIRectCorner
    ) -> some View {
        clipShape(
            RoundedCorners(
                radius: radius,
                corners: corners
            )
        )
    }
}

struct RoundedCorners: Shape {
    private let radius: CGFloat
    private let corners: UIRectCorner
    
    init(
        radius: CGFloat,
        corners: UIRectCorner
    ) {
        self.radius = radius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(
                width: radius,
                height: radius
            )
        )
        return Path(path.cgPath)
    }
}
