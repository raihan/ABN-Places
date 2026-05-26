//
//  CustomLocationViewModel.swift
//  Places
//
//  Created by Abdullah Zubair on 24/05/2026.
//

import Foundation
import CoreLocation
import Router

@MainActor
@Observable
final class CustomLocationInputViewModel {
    private let wikipediaRouter: WikipediaRouterProtocol
    var showNavigationError = false
    var invalidCoordinateMessage: String?
    var shouldDismissKeyboard: Bool = false
    
    init(wikipediaRouter: WikipediaRouterProtocol = WikipediaRouter()) {
        self.wikipediaRouter = wikipediaRouter
    }
    
    func isValidCoordinate(lat: String, long: String) -> Bool {
        guard let lat = Double(lat), let long = Double(long) else {
            return false
        }
        
        return CLLocationCoordinate2DIsValid(CLLocationCoordinate2D(latitude: lat, longitude: long))
    }
    
    func openLinkInWikipedia(lat: String, long: String) {
        let lat = lat.trimmingCharacters(in: .whitespacesAndNewlines)
        let long = long.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard isValidCoordinate(lat: lat, long: long) else {
            invalidCoordinateMessage = .errorMessage
            return
        }
        
        shouldDismissKeyboard = true
        invalidCoordinateMessage = nil
        navigateToWikipedia(lat: lat, long: long)
    }
    
    func navigateToWikipedia(lat: String, long: String) {
        Task  {
            let didNavigate = await wikipediaRouter.navigateToWikipedia(lat: lat, long: long)
            
            if !didNavigate {
                showNavigationError = true
            }
        }
    }
}

private extension String {
    static let errorMessage: String = "Please enter a valid latitude and longitude."
}
