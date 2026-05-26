//
//  LocationListViewModelTests.swift
//  Places
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import Foundation
import Testing
import CoreLocation
@testable import Models
@testable import Features

@Suite
@MainActor
struct LocationListViewModelTests {
    private let locations = Locations.mock

    @Test
    func initialState() async throws {
        // Given
        let subject = LocationListViewModel()

        // Then state is idle on launch
        #expect(subject.state == .idle)
    }

    @Test
    func fetchLocationsWhenSucceeds() async throws {
        // Given
        let locationApiMock = LocationsApiMock(locations: locations)
        let subject = LocationListViewModel(locationsApi: locationApiMock)

        // When
        await subject.fetchLocations()

        // Then
        if case .loaded(let loadedLocations) = subject.state {
            #expect(loadedLocations == locations)
        }
    }

    @Test
    func fetchLocationsWhenFails() async {
        // Given
        let locationApiMock = LocationsApiMock(
            apiError: NSError(
                domain: "domain",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "some error"]
            )
        )
        let subject = LocationListViewModel(locationsApi: locationApiMock)

        // When
        await subject.fetchLocations()

        // Then
        if case .failed(let errorMessage) = subject.state {
            #expect(errorMessage == "some error")
        }
    }

    @Test
    func navigateToWikipediaWhenSucceeds() async {
        // Given
        let router = WikipediaRouterMock()
        let subject = LocationListViewModel(wikipediaRouter: router)
        let coordinate = CLLocationCoordinate2D(latitude: 52.3547498, longitude: 4.8339215)
        
        // When
        subject.navigateToWikipedia(lat: coordinate.latitude, long: coordinate.longitude)
        await Task.yield()

        // Then
        #expect(router.lastReceivedCoordinate?.latitude == coordinate.latitude)
        #expect(router.lastReceivedCoordinate?.longitude == coordinate.longitude)
    }

    @Test
    func navigateToWikipediaWhenFails() async {
        // Given
        let router = WikipediaRouterMock()
        router.isWikipediaAppInstalled = false
        let subject = LocationListViewModel(wikipediaRouter: router)
        let coordinate = CLLocationCoordinate2D(latitude: 52.3547498, longitude: 4.8339215)

        // When
        subject.navigateToWikipedia(lat: coordinate.latitude, long: coordinate.longitude)
        await Task.yield()

        // Then
        #expect(router.openWikipediaLocationResult == false)
        #expect(subject.showNavigationError == true)
    }
}
