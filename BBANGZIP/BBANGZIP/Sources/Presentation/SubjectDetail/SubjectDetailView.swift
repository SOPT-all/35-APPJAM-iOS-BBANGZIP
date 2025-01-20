//
//  SubjectDetailView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectDetailView: View {
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    HStack {
                        CustomText(
                            "사장님의 각오 한 마디를 작성해 보세요",
                            fontType: .heading2Bold,
                            color: Color(.labelAssistive)
                        )
                        .lineLimit(2)
                        .padding(.leading, 24)
                        .padding(.trailing, 151)
                        
                        Spacer()
                    }
                    .padding(.top, 25)
                    .padding(.bottom, 72)
                    .background(
                        RoundedRectangle(cornerRadius: 32)
                            .fill(Color(.backgroundAccent))
                            .edgesIgnoringSafeArea(.top)
                    )
                    
                    Spacer()
                }
                
                VStack {
                    MenuTab(
                        tabNames: [
                            "중간고사",
                            "기말고사"
                        ]
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, 125)
                    
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    SubjectDetailView()
}
