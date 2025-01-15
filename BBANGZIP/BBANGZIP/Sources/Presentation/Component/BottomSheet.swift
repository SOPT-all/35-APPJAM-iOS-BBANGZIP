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
                                    withAnimation(.easeOut(duration: 0.2)) {
                                        currentHeight = max(CGFloat(height) - value.translation.height, 100)
                                    }
                                }
                                .onEnded { value in
                                    if value.translation.height > CGFloat(height) * 0.5 {
                                        withAnimation {
                                            isShowing = false
                                            print("Go Down")
                                            print(currentHeight)
                                        }
                                    } else {
                                        withAnimation {
                                            print("Stay")
                                            print(currentHeight)
                                            currentHeight = CGFloat(height)
                                        }
                                    }
                                }
                        )
                    
                    content()
                    
                    Spacer()
                }
                .frame(height: currentHeight)
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
                .onAppear {
                    currentHeight = CGFloat(height)
                }
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
    private let radius: CGFloat
    private let corners: UIRectCorner
    
    init(
        radius: CGFloat = .infinity,
        corners: UIRectCorner = .allCorners
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

