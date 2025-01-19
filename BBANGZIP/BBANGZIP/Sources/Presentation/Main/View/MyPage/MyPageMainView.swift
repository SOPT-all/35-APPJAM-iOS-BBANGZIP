//
//  MyPageMainView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct MyPageMainView: View {
    var body: some View {
        VStack {
            ZStack {
                Color(.backgroundAccent)
                    .cornerRadius(
                        32,
                        corners: [
                            .bottomLeft,
                            .bottomRight
                        ]
                    )
                    .frame(height:416)
                    .onTapGesture {
                        print("레벨업 상태 화면으로 change 예정")
                    }
                VStack {
                    HStack{
                        Chip(type: .level(1))
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            Spacer()
        }
    }
}

#Preview {
    MyPageMainView()
}
