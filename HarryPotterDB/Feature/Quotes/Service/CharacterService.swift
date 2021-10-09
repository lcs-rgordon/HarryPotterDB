//
//  CharactersService.swift
//  Harry Potter DB
//
//  Created by Russell Gordon on 2021-10-07.
//

import Foundation

protocol CharactersService {
    func fetchCharacters() async throws -> [Character]
}

final class CharacterServiceImplementation: CharactersService {
    
    final func fetchCharacters() async throws -> [Character] {
        
        // Start a URL session to interact with the API
        let urlSession = URLSession.shared
        // Assemble the URL that points to the JSON endpoint
        let url = URL(string: APIConstants.baseURL.appending("/api/characters"))
        // Fetch the raw data
        let (data, _) = try await urlSession.data(from: url!)
        // Attempt to decode and return the array of characters
        return try JSONDecoder().decode([Character].self, from: data)
        
    }
    
}
