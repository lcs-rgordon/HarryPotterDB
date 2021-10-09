//
//  CharactersViewModel.swift
//  Harry Potter DB
//
//  Created by Russell Gordon on 2021-10-07.
//

import Foundation

// Making the protocol conform to ObservableObject means that every conforming class will also conform to ObservableObject so that SwiftUI can see changes
protocol CharactersViewModel: ObservableObject {

    // This function will return a list of random quotes from the service
    func getCharacters() async
    
}

@MainActor
final class CharactersViewModelImplementation: CharactersViewModel, ObservableObject {
    
    @Published private(set) var characters: [Character] = []
    
    private let service: CharactersService
    
    // Inject the service object into this class
    // This class can share the instance with other classes
    init(service: CharactersService) {
        self.service = service
    }
    
    func getCharacters() async {
        do {
            self.characters = try await service.fetchCharacters()
        } catch {
            print(error)
        }
    }
    
}

