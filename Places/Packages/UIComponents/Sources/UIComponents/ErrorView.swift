//
//  ErrorView.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 24/05/2026.
//

import Foundation
import SwiftUI

public struct ErrorView: View {
    private let message: String
    private var tryAgainAction: (() -> Void)?
    
    public init(message: String, tryAgainAction: ( () -> Void)? = nil) {
        self.message = message
        self.tryAgainAction = tryAgainAction
    }
    
    public var body: some View {
        ContentUnavailableView {
            Label(String.errorLabel,
                  systemImage: .errorImage
            )
            .accessibilityElement(children: .combine)
            .accessibilityLabel(String.errorLabel)
        } description: {
            Text(message)
                .accessibilityLabel(message)
        } actions: {
            Button(String.tryAgain) {
                tryAgainAction?()
            }
            .font(.body.bold())
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(Capsule())
            .accessibilityLabel(String.tryAgain)
            .accessibilityHint(String.accessibilityHint)
        }
        .accessibilityElement(children: .contain)
    }
}

private extension String {
    static let errorLabel = "Something went wrong!"
    static let tryAgain = "Try Again"
    static let accessibilityHint = "Retries the previous action"
    static let errorImage = "exclamationmark.triangle"
}

#Preview {
    ErrorView(message: "Please try again!")
}
