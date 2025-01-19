//
//  StudyManageView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectManageView: View {
    @StateObject private var viewModel: SubjectManageViewModel
    private let selectedBottomSheetType: BottomSheetType?
    
    init(
        viewModel: SubjectManageViewModel = SubjectManageViewModel(),
        selectedBottomSheetType: BottomSheetType? = .changeSemester
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.selectedBottomSheetType = selectedBottomSheetType
    }
    
    // TODO: API 연동 후 수정 필요
    private let data = Array(1...8)
    
    private let columns = [
        GridItem(
            .flexible(),
            spacing: 20
        ),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            HStack {
                ChangeSemesterButton(viewModel: viewModel)
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
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color(.backgroundAccent))
                    .edgesIgnoringSafeArea(.top)
            )
            
            VStack(spacing: 32) {
                subjectSection
                
                ScrollView {
                    LazyVGrid(
                        columns: columns,
                        spacing: 20
                    ) {
                        ForEach(
                            data,
                            id: \.self
                        ) { i in
                            Button {
                                
                            } label: {
                                SubjectCard(
                                    state: viewModel.state,
                                    subjectCardData: SubjectCardData.mockData
                                )
                            }
                        }
                    }
                }
            }
            .padding(
                .top,
                48
            )
            .padding(
                .horizontal,
                20
            )
            
            Spacer()
            
        }
        .bottomSheet(
            isShowing: $viewModel.isShowingBottomSheet,
            height: 453
        ) {
            if let type = selectedBottomSheetType {
                type.contentView(isPresented: $viewModel.isShowingBottomSheet)
            }
        }
        
    }
    
    var subjectSection: some View {
        HStack {
            CustomText(
                "어떤 과목을 공부해 볼까요?",
                fontType: .headline2Bold,
                color: Color(.labelAlternative)
            )
            
            Spacer()
            
            Button {
                viewModel.deleteSubject()
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
    }
}

#Preview {
    SubjectManageView()
}
