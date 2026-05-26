//
//  LocationsApiMock.swift
//  Places
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import Foundation
@testable import ApiService
@testable import Features
@testable import Models
@testable import LocationsApi

actor LocationsApiMock: LocationsApiProtocol {
    let locations: Locations?
    let apiError: Error?

    init(locations: Locations? = nil, apiError: Error? = nil) {
        self.locations = locations
        self.apiError = apiError
    }
    
    func fetchLocations() async throws -> Locations {
        if let apiError {
            throw apiError
        }

        guard let locations else {
            return .mock
        }
        
        return locations
    }
}

public extension Locations {
    static let mock: Locations = Locations(
        locations: [
            Location(
                name: "Amsterdam",
                lat: 52.3547498,
                long: 4.8339215)
        ]
    )
}
