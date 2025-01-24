//
//  DivideBottomSheet.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SetPieceBottomSheet: View {
    @Binding private var isPresented: Bool
    @ObservedObject var addStudyViewModel: AddStudyViewModel
    
    @State private var startPage: Int
    @State private var endPage: Int
    @State private var totalDays: Int
    
    private let pieces = Array(1...6)
    
    init(
        isPresented: Binding<Bool>,
        startPage: Int,
        endPage: Int,
        totalDays: Int,
        addStudyViewModel: AddStudyViewModel
    ) {
        self._isPresented = isPresented
        self.startPage = startPage
        self.endPage = endPage
        self.totalDays = totalDays
        self.addStudyViewModel = addStudyViewModel
    }
    
    var body: some View {
        CustomText(
            "몇 조각으로 쪼개서 공부할까요?",
            fontType: .headline1Bold,
            color: Color(.labelNeutral)
        )
        .padding(
            .vertical,
            39
        )
        
        VStack {
            ForEach(pieces, id: \.self) { num in
                NavigationLink(
                    destination: DivideRangeView(
                        viewModel: DivideRangeViewModel(
                            pieceCount: num,
                            startPage: startPage,
                            endPage: endPage,
                            totalDays: totalDays
                        ),
                        addStudyViewModel: addStudyViewModel,
                        pieceCount: num,
                        startPage: startPage,
                        endPage: endPage,
                        totalDays: totalDays
                    )
                ) {
                    HStack {
                        Spacer()
                        
                        CustomText(
                            "\(num)조각",
                            fontType: .body1Bold,
                            color: Color(.labelNormal)
                        )
                        
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    
                }
                .padding(.horizontal, 20)
                .buttonStyle(PressedButtonStyle())
            }
        }
        .padding(
            .bottom,
            24
        )
    }
}
