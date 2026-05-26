//
//  PrimaryButton.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import SwiftUI

public struct PrimaryButton: View {
    private let title: String
    private let systemImage: String?
    private let action: () -> Void
    
    public init(title: String, systemImage: String?, action: @escaping () -> Void) {
        self.title = title
        self.systemImage = systemImage
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if let systemImage {
                    Image(systemName: systemImage)
                }
                Text(title)
                    .fontWeight(.semibold)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel(title)
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}
