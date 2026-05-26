//
//  CustomLocationInputViewModelTests.swift
//  Features
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import Foundation
import Testing
import CoreLocation
@testable import Features

@Suite
@MainActor
struct CustomLocationInputViewModelTests {

    // MARK: - isValidCoordinate

    @Test
    func isValidCoordinateWhenSucceeds() {
        let subject = CustomLocationInputViewModel()
        #expect(subject.isValidCoordinate(lat: "52.3547498", long: "4.8339215") == true)
    }

    @Test
    func isValidCoordinateWhenFails() {
        let subject = CustomLocationInputViewModel()
        #expect(subject.isValidCoordinate(lat: "1234", long: "5678") == false)
    }

    @Test
    func isValidCoordinateWithEmptyStrings() {
        let subject = CustomLocationInputViewModel()
        #expect(subject.isValidCoordinate(lat: "", long: "") == false)
    }

    @Test
    func isValidCoordinateWithWhitespace() {
        let subject = CustomLocationInputViewModel()
        #expect(subject.isValidCoordinate(lat: " ", long: " ") == false)
    }

    @Test
    func isValidCoordinateWithNonNumericInput() {
        let subject = CustomLocationInputViewModel()
        #expect(subject.isValidCoordinate(lat: "abc", long: "xyz") == false)
    }

    @Test
    func isValidCoordinateAtMaxBoundary() {
        // Exactly ±90 lat and ±180 long are valid
        let subject = CustomLocationInputViewModel()
        #expect(subject.isValidCoordinate(lat: "90", long: "180") == true)
        #expect(subject.isValidCoordinate(lat: "-90", long: "-180") == true)
    }

    @Test
    func isValidCoordinateOutOfRange() {
        let subject = CustomLocationInputViewModel()
        #expect(subject.isValidCoordinate(lat: "91", long: "0") == false)
        #expect(subject.isValidCoordinate(lat: "0", long: "181") == false)
    }

    @Test
    func isValidCoordinateNegativeValid() {
        let subject = CustomLocationInputViewModel()
        #expect(subject.isValidCoordinate(lat: "-45.0", long: "-90.0") == true)
    }

    // MARK: - openLinkInWikipedia

    @Test
    func openLinkInWikipediaWhenSucceeds() async {
        // Given
        let router = WikipediaRouterMock()
        let subject = CustomLocationInputViewModel(wikipediaRouter: router)
        let coordinate = CLLocationCoordinate2D(latitude: 52.3547498, longitude: 4.8339215)

        // When
        subject.openLinkInWikipedia(lat: String(coordinate.latitude), long: String(coordinate.longitude))
        await Task.yield()

        // Then
        #expect(subject.invalidCoordinateMessage == nil)
        #expect(router.lastReceivedCoordinate?.latitude == coordinate.latitude)
        #expect(router.lastReceivedCoordinate?.longitude == coordinate.longitude)
    }

    @Test
    func openLinkInWikipediaWhenFails() async {
        // Given
        let router = WikipediaRouterMock()
        let subject = CustomLocationInputViewModel(wikipediaRouter: router)
        let coordinate = CLLocationCoordinate2D(latitude: 1234, longitude: 5678)

        // When
        subject.openLinkInWikipedia(lat: String(coordinate.latitude), long: String(coordinate.longitude))
        await Task.yield()

        // Then
        #expect(subject.invalidCoordinateMessage != nil)
        #expect(router.lastReceivedCoordinate == nil)
    }

    @Test
    func openLinkInWikipediaTrimsWhitespace() async {
        // Given
        let router = WikipediaRouterMock()
        let subject = CustomLocationInputViewModel(wikipediaRouter: router)

        // When
        subject.openLinkInWikipedia(lat: "  52.3547498  ", long: "  4.8339215  ")
        await Task.yield()

        // Then — whitespace trimmed, coordinates accepted
        #expect(subject.invalidCoordinateMessage == nil)
        #expect(router.lastReceivedCoordinate != nil)
    }

    // MARK: - navigateToWikipedia

    @Test
    func navigateToWikipediaWhenSucceeds() async {
        // Given
        let router = WikipediaRouterMock()
        let subject = CustomLocationInputViewModel(wikipediaRouter: router)
        let coordinate = CLLocationCoordinate2D(latitude: 52.3547498, longitude: 4.8339215)

        // When
        subject.navigateToWikipedia(lat: String(coordinate.latitude), long: String(coordinate.longitude))
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
        let subject = CustomLocationInputViewModel(wikipediaRouter: router)
        let coordinate = CLLocationCoordinate2D(latitude: 52.3547498, longitude: 4.8339215)

        // When
        subject.navigateToWikipedia(lat: String(coordinate.latitude), long: String(coordinate.longitude))
        await Task.yield()

        // Then
        #expect(router.openWikipediaLocationResult == false)
        #expect(subject.showNavigationError == true)
    }
}
