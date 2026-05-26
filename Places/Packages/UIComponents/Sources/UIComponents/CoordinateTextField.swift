//
//  CoordinateTextField.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 24/05/2026.
//

import SwiftUI

public struct CoordinateTextField: View {
    private let title: String
    private let placeholder: String
    @Binding private var text: String
    
    public init(title: String, placeholder: String, text: Binding<String>) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
            
            TextField(placeholder, text: $text)
                .keyboardType(.decimalPad)
                .padding()
                .frame(height: 40)
                .background(Color(.systemBackground))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.35), lineWidth: 1)
                }
        }
    }
}

#Preview {
    @Previewable @State var sampleText: String = ""
    CoordinateTextField(
        title: "Latitude",
        placeholder: "e.g. 52.1234",
        text: $sampleText)
    .padding()
}
