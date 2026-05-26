//
//  ErrorTextView.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import SwiftUI

public struct ErrorTextView: View {
    private var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    public var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.red)
            .padding(.top, -8)
            .transition(.opacity)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Error: \(text)")
    }
}
