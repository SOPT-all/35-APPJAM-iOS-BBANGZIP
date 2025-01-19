//
//  LastRowPadding.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct LastRowPadding: ViewModifier {
    private let index: Int
    private let totalCount: Int
    private let columns: Int
    
    init(index: Int, totalCount: Int, columns: Int) {
        self.index = index
        self.totalCount = totalCount
        self.columns = columns
    }
    
    func body(content: Content) -> some View {
        if isLastRow {
            content
                .padding(
                    .bottom,
                    80
                )
        } else {
            content
        }
    }
    
    private var isLastRow: Bool {
        let lastRowStartIndex = (totalCount - 1) / columns * columns
        
        return index >= lastRowStartIndex
    }
}
