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
        #expect(router.lastReceivedCoordinate?.latitude == nil)
        #expect(router.lastReceivedCoordinate?.longitude == nil)
    }
    
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
        let coordinate = CLLocationCoordinate2D(latitude: 12345, longitude: 56789)
        // When
        subject.navigateToWikipedia(lat: String(coordinate.latitude), long: String(coordinate.longitude))
        await Task.yield()

        // Then
        #expect(router.openWikipediaLocationResult == false)
    }
}
