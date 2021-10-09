//
//  QuotesService.swift
//  SwiftUI Starter
//
//  Created by Russell Gordon on 2021-10-07.
//

import Foundation

protocol QuotesService {
    func fetchRandomQuotes() async throws -> [Quote]
}

final class QuotesServiceImplementation: QuotesService {
    
    final func fetchRandomQuotes() async throws -> [Quote] {
        
        // Start a URL session to interact with the API
        let urlSession = URLSession.shared
        // Assemble the URL that points to the JSON endpoint
        let url = URL(string: APIConstants.baseURL.appending("/api/quotes"))
        // Fetch the raw data
        let (data, _) = try await urlSession.data(from: url!)
        // Attempt to decode and return the array of quotes
        return try JSONDecoder().decode([Quote].self, from: data)
        
    }
    
}
