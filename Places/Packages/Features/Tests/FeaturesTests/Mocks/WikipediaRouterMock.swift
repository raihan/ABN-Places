//
//  WikipediaRouterMock.swift
//  LocationsApi
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import Foundation
import CoreLocation
@testable import Router

final class WikipediaRouterMock: WikipediaRouterProtocol {
    private(set) var lastReceivedCoordinate: CLLocationCoordinate2D?
    var isWikipediaAppInstalled = true
    private(set) var openWikipediaLocationResult = true

    func navigateToWikipedia(lat: String, long: String) async -> Bool {
        lastReceivedCoordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0, longitude: Double(long) ?? 0)
        openWikipediaLocationResult = isWikipediaAppInstalled
        return openWikipediaLocationResult
    }
    
    func reset() {
        lastReceivedCoordinate = nil
        openWikipediaLocationResult = true
    }
}
