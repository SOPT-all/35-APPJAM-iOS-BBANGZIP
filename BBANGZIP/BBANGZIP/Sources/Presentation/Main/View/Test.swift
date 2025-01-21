////
////  Test.swift
////  BBANGZIP
////
////  Created by 김송희 on 1/21/25.
////  Copyright © 2025 com.bbangzip. All rights reserved.
////
//
//import SwiftUI
//
//struct Test: View {
//    
//    @StateObject var viewModel = TestVM()
//    
//    var body: some View {
//        VStack {
//            NameInputView(
//                nickname: $viewModel.text
//            )
//            
//            nextButton
//        }
//    }
//    
//    private var nextButton: some View {
//        Button {
//            
//        } label: {
//            
//        }
//        .buttonStyle(
//            SolidIconButton(
//                buttonImage: Image(.chevronRightThickSmall),
//                viewModel.isValid
//            )
//        )
//        .disabled(!viewModel.isValid)
//        .padding(.horizontal, 20)
//    }
//}
//
//#Preview {
//    Test()
//}
//
//final class TestVM: ObservableObject {
//    @Published var text: String = ""
//    @Published var isValid: Bool = false
//}
//
//#Preview{
//    Test(viewModel: TestVM())
//}
