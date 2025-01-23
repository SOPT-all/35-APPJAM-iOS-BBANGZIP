//
//  SplashView.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack{
            Color(.yellow95)
                .ignoresSafeArea()

            VStack {
                Spacer()
                
                Image(.splash)
                    .resizable()
                    .frame(width: 252, height: 140)
                
                Spacer()
                
                Image(.corporation)
                
            }.background(Color(.yellow95))
        }
    }
}

#Preview {
    SplashView()
}
