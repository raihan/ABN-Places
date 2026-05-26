//
//  LocationRowView.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 24/05/2026.
//

import SwiftUI

public struct LocationRowViewModel {
    fileprivate var title: String?
    fileprivate var subtitle: String
    
    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}

public struct LocationRowView: View {
    private let viewModel: LocationRowViewModel
    
    public init(viewModel: LocationRowViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(viewModel.title ?? "")
                .font(.headline)
           
            Text(viewModel.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityText)
        .accessibilityHint(String.accessibilityHint)
    }
    
    private var accessibilityText: String {
        if let title = viewModel.title, !title.isEmpty {
            return "\(title), \(viewModel.subtitle)"
        } else {
            return viewModel.subtitle
        }
    }
}

private extension String {
    static let accessibilityHint = "Opens location in Wikipedia"
}
