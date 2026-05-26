//
//  LocationListView.swift
//  Places
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import SwiftUI
import UIComponents
import Models


struct LocationListView: View {
    @Bindable var viewModel: LocationListViewModel

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView()
                    .accessibilityLabel(String.loadingLocations)

            case .loaded(let locations):
                myLocationsView(locations: locations)
                    .accessibilityElement(children: .contain)

            case .failed(let errorMessage):
                ErrorView(message: errorMessage) {
                    fetchLocations()
                }
            }
        }
        .navigationErrorAlert(isPresented: $viewModel.showNavigationError)
        .onViewDidLoad {
            fetchLocations()
        }
    }

    
    @discardableResult
    private func fetchLocations() -> Task<(), Never> {
        return Task {
            await viewModel.fetchLocations()
        }
    }
    
    private func myLocationsView(locations: Locations) -> some View {
        ForEach(locations.locations) { location in
            LocationRowView(viewModel: location.locationRowViewModel)
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.navigateToWikipedia(lat: location.lat, long: location.long)
                }
                .accessibilityAddTraits(.isButton)
        }
    }
}

private extension Location {
    var locationRowViewModel: LocationRowViewModel {
        LocationRowViewModel(title: name ?? .unknownLocation, subtitle: "\(lat) \(long)")
    }
}

private extension String {
    static let loadingLocations = "Loading locations"
    static let unknownLocation = "Unknown Location"
}
