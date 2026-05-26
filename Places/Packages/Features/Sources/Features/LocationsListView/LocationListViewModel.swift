//
//  LocationsViewModel.swift
//  Places
//
//  Created by Abdullah Zubair on 23/05/2026.
//

import Foundation
import Observation
import LocationsApi
import Models
import Router

@MainActor
@Observable
final class LocationListViewModel {
    var state: LoadingState = .idle
    var showNavigationError = false
    
    private let locationsApi: LocationsApiProtocol
    private let wikipediaRouter: WikipediaRouterProtocol

    public init(locationsApi: LocationsApiProtocol = LocationsApi(), wikipediaRouter: WikipediaRouterProtocol = WikipediaRouter()) {
        self.locationsApi = locationsApi
        self.wikipediaRouter = wikipediaRouter
    }
        
    func fetchLocations() async {
        state = .loading
        
        do {
            let locations = try await locationsApi.fetchLocations()
            self.state = .loaded(locations)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }
    
    func navigateToWikipedia(lat: Double, long: Double) {
        Task {
            let didNavigate = await wikipediaRouter.navigateToWikipedia(lat: String(lat), long: String(long))
            
            if !didNavigate {
                showNavigationError = true
            }
        }
    }
}

extension LocationListViewModel {
    enum LoadingState: Equatable {
        case idle
        case loading
        case loaded(Locations)
        case failed(String)
    }
}
