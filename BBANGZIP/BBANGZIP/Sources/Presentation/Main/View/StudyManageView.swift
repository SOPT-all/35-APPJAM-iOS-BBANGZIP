//
//  StudyManageView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyManageView: View {
    @State var isShowingBottomSheet = false
    @State private var selectedBottomSheetType: BottomSheetType? = .changeSemester
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    isShowingBottomSheet = true
                } label: {
                    HStack(spacing: 4) {
                        CustomText(
                            "2025년 1학기",
                            fontType: .body1Bold,
                            color: Color(.labelNormal)
                        )
                        
                        Image(.chevronDown)
                            .renderingMode(.template)
                            .resizable()
                            .frame(
                                width: 20,
                                height: 20
                            )
                            .foregroundStyle(Color(.labelNormal))
                    }
                }
                .padding(
                    .leading,
                    24
                )
                
                Spacer()
            }
            .padding(
                .top,
                16
            )
            .padding(
                .bottom,
                169
            )
            .background(RoundedRectangle(cornerRadius: 32)
                .fill(Color(.backgroundAccent))
                .edgesIgnoringSafeArea(.top)
            )
            
            VStack {
                HStack {
                    CustomText(
                        "어떤 과목을 공부해 볼까요?",
                        fontType: .headline2Bold,
                        color: Color(.labelAlternative)
                    )
                    
                    Spacer()
                    
                    Button {
                         
                    } label: {
                        Image(.trash)
                            .renderingMode(.template)
                            .resizable()
                            .scaledToFit()
                            .frame(
                                width: 24,
                                height: 24
                            )
                            .foregroundStyle(Color(.labelAssistive))
                    }
                }
                
                HStack(spacing: 20) {
                    VStack(spacing: 8) {
                        CircleIcon(name: "Plus")
                            .padding(
                                .horizontal,
                                59
                            )
                        
                        CustomText(
                            "과목추가",
                            fontType: .body1Bold,
                            color: Color(.labelDisable)
                        )
                    }
                    .padding(
                        .vertical,
                        59
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .foregroundStyle(Color(.staticWhite))
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(
                                        Color(
                                            .lineAlternative
                                        ),
                                        lineWidth: 2
                                    )
                            )
                            .shadow(
                                color: Color(.staticBlack).opacity(0.25),
                                radius: 4,
                                y: 4
                            )
                    )
                    
                    VStack(spacing: 8) {
                        CircleIcon(name: "Plus")
                            .padding(.horizontal, 59)
                        
                        CustomText(
                            "과목추가",
                            fontType: .body1Bold,
                            color: Color(.labelDisable)
                        )
                    }
                    .padding(.vertical, 59)
                    .background(RoundedRectangle(cornerRadius: 24)
                        .foregroundStyle(Color(.staticWhite))
                        .shadow(
                            color: Color(.staticBlack).opacity(0.25),
                            radius: 4,
                            y: 4
                        ))
                    
                }
                .padding(.top, 32)
                    
            }
            .padding(
                .top,
                48
            )
            .padding(
                .leading,
                20
            )
            .padding(
                .trailing,
                20
            )
            
            Spacer()
            
        }
        .overlay(
                bottomSheet(
                    isShowing: $isShowingBottomSheet,
                    height: 453
                ) {
                    if let type = selectedBottomSheetType {
                        type.contentView(isPresented: $isShowingBottomSheet)
                    }
                }
            
        )
    }
}

#Preview {
    StudyManageView()
}
