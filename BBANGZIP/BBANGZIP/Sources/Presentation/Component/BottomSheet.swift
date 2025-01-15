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
    case examDate
    case studyFinishDate
    case changeSemester
    
    func view() -> AnyView {
        switch self {
        // TODO: BottomSheet를 사용하는 View 구현 후 임시 뷰 제거 필요
        case .revert:
            AnyView(Text("미완료 상태로 되돌릴까요?"))
        case .sort:
            AnyView(Text("최근 등록 순"))
        case .withdraw:
            AnyView(Text("정말 탈퇴하시겠어요?"))
        case .detailBadge:
            AnyView(Text("배지 달성 조건과 리워드"))
        case .congratsBadge:
            AnyView(Text("배지를 획득했어요!"))
        case .examDate:
            AnyView(Text("시험이 언제인가요?"))
        case .studyFinishDate:
            AnyView(Text("언제까지 공부할까요?"))
        case .changeSemester:
            AnyView(Text("어떤 학기로 변경할까요?"))
        }
    }
}

struct BottomSheet<Content: View>: View {
    @Binding private var isShowing: Bool
    private let height: Int
    private let content: () -> Content
    
    @GestureState private var dragPosition = CGFloat.zero
    
    init(
        isShowing: Binding<Bool>,
        height: Int,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isShowing = isShowing
        self.height = height
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if isShowing {
                Color.black
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowing.toggle()
                    }
                
                VStack() {
                    RoundedRectangle(cornerRadius: 2.5)
                        .fill(Color(.interactionInactive))
                        .frame(
                            width: 36,
                            height: 5
                        )
                        .padding(.top, 8)
                        .gesture(
                            DragGesture()
                                .updating($dragPosition) {
                                    value,
                                    state,
                                    transaction in
                                    state = value.translation.height
                                }
                                .onEnded { value in
                                    if value.translation.height > 100 {
                                        withAnimation {
                                            isShowing = false
                                        }
                                    }
                                }
                        )
                    
                    content()
                    
                    Spacer()
                }
                .frame(height: CGFloat(height))
                .frame(maxWidth: .infinity)
                .background(
                    Color(.backgroundNormal)
                )
                .cornerRadius(
                    48,
                    corners: [
                        .topLeft,
                        .topRight
                    ]
                )
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
        .animation(
            .easeInOut,
            value: isShowing
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
    private var radius: CGFloat = .infinity
    private var corners: UIRectCorner = .allCorners
    
    init(radius: CGFloat, corners: UIRectCorner) {
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

