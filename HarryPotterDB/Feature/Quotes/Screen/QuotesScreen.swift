//
//  QuotesScreen.swift
//  SwiftUI Starter
//
//  Created by Russell Gordon on 2021-10-07.
//

import SwiftUI

struct QuotesScreen: View {
    
    // Source of truth for the view model – initial instance
    @StateObject private var vm = QuotesViewModelImplementation(
        service: QuotesServiceImplementation()
    )
    
    var body: some View {
        
        Group {
            
            if vm.quotes.isEmpty {
                LoadingView(text: "Fetching quotes")
            } else {
                List {
                    
                    // Display the list of quotes
                    ForEach(vm.quotes, id: \.anime) { item in
                        
                        QuoteView(item: item)
                        
                    }
                    
                }
            }
            
        }
        .task {
            // Wait for the quotes to be retrieved from the API
            await vm.getRandomQuotes()
        }
        
    }
    
}

struct QuotesScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuotesScreen()
    }
}
