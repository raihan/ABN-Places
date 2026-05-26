import Foundation
import Testing
@testable import Router

@MainActor
struct RouterTests {
    @Test
    func navigateToWikipediaWhenSucceeds() async {
        // Given
        let application = MockApplication()
        let subject = WikipediaRouter(application: application)
        
        // When
        let result = await subject.navigateToWikipedia(
            lat: "19.0823998",
            long: "72.8111468"
        )
        
        // Then
        #expect(result == true)
        #expect(application.openedURL?.absoluteString.contains("latitude") == true)
        #expect(application.openedURL?.absoluteString.contains("longitude") == true)
        #expect(application.openedURL?.absoluteString.contains("WMFArticleURL") == true)
    }
    
    @Test
    func navigateToWikipediaWhenFails() async {
        // Given
        let application = MockApplication(openResult: false)
        let subject = WikipediaRouter(application: application)
        
        // When
        let result = await subject.navigateToWikipedia(
            lat: "19.0823998",
            long: "72.8111468"
        )
        
        // Then
        #expect(result == false)
        #expect(application.openedURL?.absoluteString.contains("latitude") == true)
        #expect(application.openedURL?.absoluteString.contains("longitude") == true)
        #expect(application.openedURL?.absoluteString.contains("WMFArticleURL") == true)
    }
}
