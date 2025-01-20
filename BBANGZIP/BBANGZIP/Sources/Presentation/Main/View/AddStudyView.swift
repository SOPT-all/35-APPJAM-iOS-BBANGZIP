//
//  addStudyView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct AddStudyView: View {
    @ObservedObject var viewModel: AddStudyViewModel
    @State private var isDatePickerPresented = false
    
    var body: some View {
        VStack{
            ZStack{
                subjectTitle
                
                HStack {
                    backButton
                        .padding(16)
                    Spacer()
                }
            }
            .padding(
                .bottom,
                16
            )
            
            VStack(spacing: 0) {
                dateTitle
                
                dateTextField
                
                studyContentTitle
                
                studyContentField
                
                studyRangeTitle
                
                HStack(spacing: 20) {
                    startRangeTextField
                    
                    endRangeTextField
                }
                
                divideButton
                
                tipText
                
                Spacer()
                
                registerButton
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    // TODO: 뒤로가기 버튼 ToolBar로 리팩토링 필요
    private var backButton: some View {
        HStack {
            Image(.chevronLeftThickSmall)
                .renderingMode(.template)
                .foregroundStyle(Color(.labelAlternative))
        }
    }
    
    private var subjectTitle: some View {
        CustomText(
            "경제통계학",
            fontType: .headline1Bold,
            color: Color(.labelNeutral)
        )
    }
    
    private var dateTitle: some View {
        HStack {
            CustomText(
                "시험 일자",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            16
        )
    }
    
    private var dateTextField: some View {
        TextField(
            "시험 일자 입력",
            text: .constant(viewModel.formattedDate)
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: .constant(viewModel.formattedDate),
                style: .date,
                state: viewModel.dateState
            )
        )
        .disabled(true)
        .onTapGesture {
            // TODO: 바텀시트 연결
            isDatePickerPresented = true
        }
        .padding(
            .bottom,
            50
        )
    }
    
    private var studyContentTitle: some View {
        HStack {
            CustomText(
                "학습 내용",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            16
        )
    }
    
    private var studyContentField: some View {
        TextField(
            "예) 교재 이름, PPT 1과",
            text: $viewModel.studyContent
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.studyContent,
                style: .studyContent,
                state: viewModel.contentState,
                alertText: viewModel.contentAnnounceState
            )
        )
        .padding(
            .bottom,
            32
        )
    }
    
    private var studyRangeTitle: some View {
        HStack {
            CustomText(
                "학습 범위",
                fontType: .body1Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            16
        )
    }
    
    private var startRangeTextField: some View {
        TextField(
            "시작 페이지",
            text: $viewModel.startRangeString
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.startRangeString,
                style: .studyRange,
                state: viewModel.startRangeState,
                alertText: viewModel.startRangeAnnounceState
            )
        )
        .padding(
            .bottom,
            16
        )
    }
    
    private var endRangeTextField: some View {
        TextField(
            "종료 페이지",
            text: $viewModel.endRangeString
        )
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.endRangeString,
                style: .studyRange,
                state: viewModel.endRangeState,
                alertText: viewModel.endRangeAnnounceState
            )
        )
        .padding(
            .bottom,
            16
        )
    }
    
    private var divideButton: some View {
        Button("쪼개서 공부하기") {
            // TODO: 나누어 공부하기 뷰로 화면 전환
        }
        .buttonStyle(
            OutlinedMediumButton()
        )
        .padding(
            .bottom,
            8
        )
    }
    
    private var tipText: some View {
        HStack {
            CustomText(
                "[Tip] 입력하신 학습 범위를 자동으로 분배하여\n꾸준히 공부할 수 있도록 학습 계획을 세워드려요!",
                fontType: .caption2Bold,
                color: Color(.labelAssistive)
            )
            
            Spacer()
        }
    }
    
    private var registerButton: some View {
        Button("공부 내용 등록하기") {
            // TODO: 화면 전환해야 할 다음 뷰로 연결
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.plus)
            )
        )
    }
}

#Preview {
    AddStudyView(
        viewModel: AddStudyViewModel()
    )
}
