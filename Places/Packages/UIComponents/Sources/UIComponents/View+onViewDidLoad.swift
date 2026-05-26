//
//  View+onViewDidLoad.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 24/05/2026.
//


import SwiftUI

public extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}

/// Reusable `viewDidLoad()` modifier
struct ViewDidLoadModifier: ViewModifier {
    @State private var isViewLoaded = false
    let action: (() -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear {
                if isViewLoaded == false {
                    isViewLoaded = true
                    action?()
                }
            }
    }
}
