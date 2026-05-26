//
//  WikipediaRouterMock.swift
//  LocationsApi
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import Foundation
import CoreLocation
@testable import Router

@MainActor
final class WikipediaRouterMock: WikipediaRouterProtocol {
    private(set) var lastReceivedCoordinate: CLLocationCoordinate2D?
    var isWikipediaAppInstalled = true
    private(set) var openWikipediaLocationResult = true

    func navigateToWikipedia(lat: String, long: String) async -> Bool {
        if let latDouble = Double(lat), let longDouble = Double(long) {
            lastReceivedCoordinate = CLLocationCoordinate2D(latitude: latDouble, longitude: longDouble)
        }
        openWikipediaLocationResult = isWikipediaAppInstalled
        return openWikipediaLocationResult
    }

    func reset() {
        lastReceivedCoordinate = nil
        openWikipediaLocationResult = true
    }
}
