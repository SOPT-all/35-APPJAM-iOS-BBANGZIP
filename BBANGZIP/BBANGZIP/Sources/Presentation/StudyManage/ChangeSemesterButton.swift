//
//  ChangeSemesterButton.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ChangeSemesterButton: View {
    @ObservedObject var viewModel: SubjectManageViewModel
    
    init(viewModel: SubjectManageViewModel = SubjectManageViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Button {
            viewModel.showChangeSemesterSheet()
        } label: {
            HStack(spacing: 4) {
                CustomText(
                    // TODO: API 연동 후 변경 필요
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
    }
}
