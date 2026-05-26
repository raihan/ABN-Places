//
//  ErrorAlert.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 26/05/2026.
//

import SwiftUI

public struct ErrorAlert: ViewModifier {
    @Binding var isPresented: Bool

    public func body(content: Content) -> some View {
        content
            .alert(String.unableToOpenWikipediaApp, isPresented: $isPresented) {
                Button(String.buttonText, role: .cancel) {}
                    .accessibilityLabel(String.buttonText)
            } message: {
                Text(String.pleaseMakeSureTheWikipediaAppIsInstalled)
                    .accessibilityLabel(String.pleaseMakeSureTheWikipediaAppIsInstalled)
            }
    }
}

public extension View {
    func navigationErrorAlert(isPresented: Binding<Bool>) -> some View {
        modifier(ErrorAlert(isPresented: isPresented))
    }
}

private extension String {
    static let buttonText = "Ok"
    static let unableToOpenWikipediaApp = "Unable to open Wikipedia App"
    static let pleaseMakeSureTheWikipediaAppIsInstalled = "Please make sure the Wikipedia app is installed."
}
