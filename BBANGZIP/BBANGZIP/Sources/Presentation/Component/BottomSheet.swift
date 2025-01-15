//
//  BottomSheet.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum BottomSheetType: Int {
    case revert
    case sort
    case withdraw
    case detailBadge
    case congratsBadge
    
    func view() -> AnyView {
        switch self {
        case .revert:
            return AnyView(Text("미완료 상태로 되돌릴까요?"))
        case .sort:
            return AnyView(Text("최근 등록 순"))
        case .withdraw:
            return AnyView(Text("정말 탈퇴하시겠어요?"))
        case .detailBadge:
            return AnyView(Text("배지 달성 조건과 리워드"))
        case .congratsBadge:
            return AnyView(Text("배지를 획득했어요!"))
        }
    }
}

struct BottomSheet: View {
    
    @Binding var isShowing: Bool
    private let height: Int
    private var content: AnyView
    
    init(isShowing: Binding<Bool>, height: Int, content: AnyView) {
        self._isShowing = isShowing
        self.height = height
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if (isShowing) {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                
                VStack() {
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color(.interactionInactive))
                        .frame(width: 36, height: 5)
                        .padding(.top, 8)
                    
                    content
                    
                    Spacer()
                }
                .frame(height: CGFloat(height))
                .frame(maxWidth: .infinity)
                .background(
                    Color(.backgroundNormal)
                )
                .cornerRadius(48, corners: [.topLeft, .topRight])
                .shadow(
                    color: Color(.staticBlack).opacity(0.25),
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
        .animation(.easeInOut, value: isShowing)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(
            RoundedCorners(
                radius: radius,
                corners: corners
            )
        )
    }
}

struct RoundedCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

