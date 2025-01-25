import SwiftUI

struct SubjectCard: View {
    private var state: CardState
    private let subjectCardData: SubjectCardModel
    private let borderPadding: CGFloat = 2
    
    init(
        state: CardState,
        subjectCardData: SubjectCardModel
    ) {
        self.state = state
        self.subjectCardData = subjectCardData
    }
    
    private var shouldShowEmptyState: Bool {
        
        return priorityStudy == nil
    }

    private var priorityStudy: SubjectStudyModel? {
        let midtermStudy = subjectCardData.studyList.filter { $0.examName == "중간고사" && $0.isValidExam }
        let finalStudy = subjectCardData.studyList.filter { $0.examName == "기말고사" && $0.isValidExam }
        
        if !midtermStudy.isEmpty {
            return midtermStudy.first
        }
        if !finalStudy.isEmpty {
            return finalStudy.first
        }
        
        return nil
    }
    
    var body: some View {
        ZStack {
            backgroundView
            
            if shouldShowEmptyState {
                emptyStateView
            } else if let study = priorityStudy {
                normalStateView(study: study)
            }
        }
        .frame(height: 190)
        .padding(borderPadding)
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(state.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        state.borderColor,
                        lineWidth: state.borderWidth
                    )
            )
            .customShadow(.normal)
    }
    
    private func delayedStudyView(study: SubjectStudyModel) -> some View {
        HStack(spacing: 4) {
            PushIcon(
                number: study.pendingCount,
                type: .orange
            )
            
            CustomText(
                "밀린 공부",
                fontType: .caption1Bold,
                color: Color(.labelAssistive)
            )
        }
    }
    
    private func inProgressStudyView(study: SubjectStudyModel) -> some View {
        HStack(spacing: 4) {
            PushIcon(
                number: study.inProgressCount,
                type: .black
            )
            
            CustomText(
                "진행 중인 공부",
                fontType: .caption1Bold,
                color: Color(.labelAssistive)
            )
        }
    }

    private var emptyStateView: some View {
        HStack {
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                CustomText(
                    subjectCardData.subjectName,
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
                .lineLimit(1)
                
                CustomText(
                    "공부를 추가해주세요",
                    fontType: .label2Bold,
                    color: Color(.labelNeutral)
                )
                
                Spacer()
            }
            .padding(
                .vertical,
                16
            )
            .padding(
                .leading,
                16
            )
            
            Spacer()
            
            Image(.chevronRightThickSmall)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(Color(.labelAssistive))
                .frame(width: 16, height: 16)
                .padding(
                    .trailing,
                    6
                )
        }
    }

    private func normalStateView(study: SubjectStudyModel) -> some View {
        HStack(alignment: .center) {
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                CustomText(
                    subjectCardData.subjectName,
                    fontType: .body1Bold,
                    color: Color(.labelNormal)
                )
                .lineLimit(1)
                
                CustomText(
                    study.examName,
                    fontType: .label2Bold,
                    color: Color(.labelNeutral)
                )
                
                Chip(type: .daysLeftBlack(-study.examDDay))
                
                Spacer()
                
                delayedStudyView(study: study)
                
                inProgressStudyView(study: study)
            }
            .padding(
                .vertical,
                16
            )
            .padding(
                .leading,
                16
            )
            
            Spacer()
            
            Image(.chevronRightThickSmall)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(Color(.labelAssistive))
                .frame(width: 16, height: 16)
                .padding(
                    .trailing,
                    6
                )
        }
    }
}
