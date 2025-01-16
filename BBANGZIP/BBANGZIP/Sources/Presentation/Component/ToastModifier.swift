//
//  ToastModifier.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    @State private var task: Task<Void, Never>?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    if let toast = toast {
                        VStack(spacing: 0) {
                            Spacer()
                            
                            ToastView(toast: toast)
                                .padding(.bottom, toast.bottomPadding)
                        }
                        .transition(.opacity)
                    }
                }
                .animation(
                    .spring,
                    value: toast
                )
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    private func showToast() {
        guard toast != nil else { return }
        
        task?.cancel()
        
        task = Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            dismissToast()
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        task?.cancel()
        task = nil
    }
    
}

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
