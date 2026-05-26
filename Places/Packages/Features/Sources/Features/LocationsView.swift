//
//  ContentView.swift
//  Places
//
//  Created by Abdullah Zubair on 23/05/2026.
//

import SwiftUI
import UIComponents
import Models

public struct LocationsView: View {
    public init() {}
    
    public var body: some View {
        NavigationStack {
            List {
                Section {
                    CustomLocationInputView(viewModel: CustomLocationInputViewModel())
                } header: {
                    Text(String.customLocationSectionTitle)
                        .accessibilityAddTraits(.isHeader)
                }
                
                Section {
                    LocationListView(viewModel: LocationListViewModel())
                } header: {
                    Text(String.myLocationSectionTitle)
                        .accessibilityAddTraits(.isHeader)
                }
            }
            .navigationTitle(String.navigationTitle)
            .accessibilityLabel(String.navigationTitle)
        }
    }
}

#Preview {
    LocationsView()
}

private extension String {
    static let customLocationSectionTitle = "Open a location in Wikipedia Places"
    static let myLocationSectionTitle = "My Locations"
    static let navigationTitle = "Places"
}
