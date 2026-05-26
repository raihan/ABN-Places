//
//  WikipediaRouter.swift
//  Places
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import SwiftUI
import CoreLocation

@MainActor
public protocol WikipediaRouterProtocol {
    func navigateToWikipedia(lat: String, long: String) async -> Bool
}

@MainActor
public final class WikipediaRouter: WikipediaRouterProtocol {
    private let application: UIApplicationType
    
    public init(application: UIApplicationType = UIApplication.shared) {
        self.application = application
    }
    
    @discardableResult
    public func navigateToWikipedia(lat: String, long: String) async -> Bool {
        guard var wikiBaseUrl: URLComponents = .wikiBaseUrl else { return false }
        guard var wikiDeepLink: URLComponents = .wikiDeepLink else { return false }

        wikiBaseUrl.queryItems = [
            URLQueryItem(name: .latitudeKey,  value: lat),
            URLQueryItem(name: .longitudeKey, value: long),
        ]
        
        wikiDeepLink.queryItems = [
            URLQueryItem(name: .wmfArticleURLKey, value: wikiBaseUrl.url?.absoluteString)
        ]

        guard let deepLinkUrl = wikiDeepLink.url else { return false }

        return await application.open(deepLinkUrl)
    }
}

@MainActor
public protocol UIApplicationType {
    func open(_ url: URL) async -> Bool
}

extension UIApplication: UIApplicationType {
    public func open(_ url: URL) async -> Bool {
        return await open(url, options: [:])
    }
}

extension URLComponents {
    static let wikiDeepLink = URLComponents(string: "wikipedia://places")
    static let wikiBaseUrl = URLComponents(string: "https://en.wikipedia.org/wiki")
}

extension String {
    static let latitudeKey = "latitude"
    static let longitudeKey = "longitude"
    static let wmfArticleURLKey = "WMFArticleURL"
    static let deeplinkErrorMessage = "Wikipedia app is not installed in the device."
}
