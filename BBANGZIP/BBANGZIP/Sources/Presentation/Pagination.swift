//
//  Pagination.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct Pagination: View {
    private let totalPage: Int
    private let nowPage: Int
    
    init(totalPage: Int, nowPage: Int) {
        self.totalPage = totalPage
        self.nowPage = nowPage
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1..<totalPage+1, id: \.self) { index in
                Circle()
                    .fill(index == nowPage ? Color(.materialDimmer) : Color(.materialDimmer).opacity(0.16))
                    .frame(width: 6, height: 6)
                    .padding(.trailing, index == totalPage ? 0 : 8)
            }
        }
    }
}

#Preview {
    Pagination(totalPage: 4, nowPage: 1)
}
