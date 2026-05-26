//
//  ApiProtocol.swift
//  ApiService
//
//  Created by Abdullah Zubair on 23/05/2026.
//

import SwiftUI

public protocol ApiServiceProtocol: Actor {
    func send<T: Decodable>(_ routeRequest: Request,_ responseType: T.Type) async throws (ApiError) -> T
}
