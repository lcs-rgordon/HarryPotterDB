//
//  QuotesViewModel.swift
//  SwiftUI Starter
//
//  Created by Russell Gordon on 2021-10-07.
//

import Foundation

// Making the protocol conform to ObservableObject means that every conforming class will also conform to ObservableObject so that SwiftUI can see changes
protocol QuotesViewModel: ObservableObject {

    // This function will return a list of random quotes from the service
    func getRandomQuotes() async
    
}

@MainActor
final class QuotesViewModelImplementation: QuotesViewModel {
    
    @Published private(set) var quotes: [Quote] = []
    
    private let service: QuotesService
    
    // Inject the service object into this class
    // This class can share the instance with other classes
    init(service: QuotesService) {
        self.service = service
    }
    
    func getRandomQuotes() async {
        do {
            self.quotes = try await service.fetchRandomQuotes()
        } catch {
            print(error)
        }
    }
    
}

