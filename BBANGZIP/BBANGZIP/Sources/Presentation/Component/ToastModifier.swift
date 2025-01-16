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
    @State private var workItem: DispatchWorkItem?
    
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
                        .spring(),
                        value: toast
                    )
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    private func showToast() {
        guard toast != nil else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        workItem?.cancel()
        workItem = DispatchWorkItem {
            dismissToast()
        }
        
        if let workItem = workItem {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: workItem)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }

}

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}
