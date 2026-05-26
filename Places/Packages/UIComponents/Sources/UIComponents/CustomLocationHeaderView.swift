//
//  CustomLocationHeaderView.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 24/05/2026.
//

import SwiftUI

public struct CustomLocationHeaderView: View {
    public init() {}
    
    public var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 14) {
                Image(.imageName)
                    .font(.system(size: 30))
                    .foregroundStyle(.blue)
                    .padding(.trailing, -8)
                    .accessibilityHidden(true)
                
                Text(String.customLocation)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            Text(String.enterLatitudeAndLongitude)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(String.customLocation)
        .accessibilityValue(String.enterLatitudeAndLongitude)
    }
}

private extension String {
    static let imageName = "location"
    static let customLocation = "Custom Location"
    static let enterLatitudeAndLongitude = "Enter latitude and longitude"
}

#Preview {
    CustomLocationHeaderView()
}
