//
//  CustomLocationView.swift
//  UIComponents
//
//  Created by Abdullah Zubair on 24/05/2026.
//

import SwiftUI
import UIComponents

struct CustomLocationInputView: View {
    @State private var lat: String = ""
    @State private var long: String = ""
    @Bindable var viewModel: CustomLocationInputViewModel
    @FocusState private var focusedField: Field?
    
    enum Field {
        case latitude
        case longitude
    }
        
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            CustomLocationHeaderView()
            
            coordinateInputFields()
            
            if let errorMessage = viewModel.invalidCoordinateMessage {
                ErrorTextView(text: errorMessage)
            }
            
            PrimaryButton(title: .buttonTitle, systemImage: .buttonSystemImage) {
                viewModel.openLinkInWikipedia(lat: lat, long: long)
            }
            .accessibilityHint(String.buttonAccessibilityHint)
        }
        .onChange(of: viewModel.shouldDismissKeyboard) { _, shouldDismiss in
            if shouldDismiss {
                focusedField = nil
                viewModel.shouldDismissKeyboard = false
            }
        }
        .padding(.vertical, 8)
        .navigationErrorAlert(isPresented: $viewModel.showNavigationError)
        .accessibilityElement(children: .contain)
    }
    
    private func coordinateInputFields() -> some View {
        HStack {
            CoordinateTextField(
                title: .latTitle,
                placeholder: .latPlaceholder,
                text: $lat)
            .focused($focusedField, equals: .latitude)
            .accessibilityHint(String.latAccessibilityHint)

            
            CoordinateTextField(
                title: .longTitle,
                placeholder: .longPlaceholder,
                text: $long)
            .focused($focusedField, equals: .longitude)
            .accessibilityHint(String.longAccessibilityHint)
        }
    }
}

#Preview {
    CustomLocationInputView(viewModel: CustomLocationInputViewModel())
        .padding()
}

private extension String {
    static let latTitle: String = "Latitude"
    static let longTitle: String = "Longitude"
    static let latPlaceholder: String = "e.g. 52.3676"
    static let longPlaceholder: String = "e.g. 4.9041"
    static let latAccessibilityHint: String = "Enter the latitude coordinate"
    static let longAccessibilityHint: String = "Enter the longitude coordinate"

    static let buttonTitle: String = "Open in Wikipedia"
    static let buttonAccessibilityHint: String = "Opens the selected location in the Wikipedia app"
    static let buttonSystemImage: String = "arrow.up.forward.square"
}
