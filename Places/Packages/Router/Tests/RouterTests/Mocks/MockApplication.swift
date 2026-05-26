//
//  MockApplication.swift
//  Router
//
//  Created by Abdullah Zubair on 25/05/2026.
//

import Foundation
@testable import Router

final class MockApplication: UIApplicationType {
    private let openResult: Bool

    private(set) var openedURL: URL?

    init(openResult: Bool = true) {
        self.openResult = openResult
    }

    func open(_ url: URL) async -> Bool {
        openedURL = url
        return openResult
    }
}
