//
//  ChangeSubjectNameViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class ChangeSubjectNameViewModel: ObservableObject {
    private let changeNameUseCase: ChangeNameUseCase
    private let parentViewModel: SubjectDetailViewModel
    
    @Published var subject: String
    @Published var subjectAnnounceState: SubjectTextFieldAlertCase?
    @Published var subjectState: TextFieldState
    @Published var isSubjectFocused: Bool = false
    @Published var isSubjectValid: Bool = false
    @Published var isButtonEnabled: Bool = false
    @Published var shouldDismiss: Bool = false
    @Published var toast: Toast?
    
    init(
        changeNameUseCase: ChangeNameUseCase,
        parentViewModel: SubjectDetailViewModel,
        subject: String = "",
        subjectAnnounceState: SubjectTextFieldAlertCase? = .alert,
        subjectState: TextFieldState = .defaultState,
        isSubjectFocused: Bool = false,
        isSubjectValid: Bool = false,
        isButtonEnabled: Bool = false
    ) {
        self.changeNameUseCase = changeNameUseCase
        self.parentViewModel = parentViewModel
        self.subject = subject
        self.subjectAnnounceState = subjectAnnounceState
        self.subjectState = subjectState
        self.isSubjectFocused = isSubjectFocused
        self.isSubjectValid = isSubjectValid
        self.isButtonEnabled = isButtonEnabled
    }
    
    func verifySubject(
        newText: String,
        isSubjectFocused: Bool
    ) {
        if isSubjectFocused {
            subjectState = .typing
            
            if newText.isEmpty {
                subjectState = .defaultState
                subjectAnnounceState = .alert
                isSubjectValid = false
            } else {
                if newText.isValidSubject {
                    subjectState = .typing
                    subjectAnnounceState = .enable
                    isSubjectValid = true
                } else {
                    subjectState = .alert
                    subjectAnnounceState = .alert
                    isSubjectValid = false
                }
            }
        } else if newText.isEmpty {
            subjectState = .defaultState
            subjectAnnounceState = .alert
            isSubjectValid = false
        }
    }
    
    func handleSubjectFocusChange(
        newText: String,
        isSubjectFocused: Bool
    ) {
        if !isSubjectFocused {
            if newText.isEmpty {
                subjectState = .defaultState
                isSubjectValid = false
            } else if newText.isValidSubject {
                subjectState = .field
                subjectAnnounceState = .enable
                isSubjectValid = true
            } else {
                subjectState = .alert
                subjectAnnounceState = .alert
                isSubjectValid = false
            }
        } else {
            subjectState = .placeholder
            isSubjectValid = false
        }
        
        isButtonEnabled = subjectAnnounceState == .enable
    }
    
    @MainActor
    func changeSubjectName() async {
        do {
            let _: () = try await changeNameUseCase.execute(
                subjectId: parentViewModel.subjectId,
                options: "subjectName",
                value: subject
            )
            
            await parentViewModel.fetchData()
                    
            parentViewModel.toast = Toast(
                "과목명 수정 완료!",
                startFrom: 20
            )
                    
            self.shouldDismiss = true
            
        } catch {
            dump(error)
            print(error)
        }
    }
}
