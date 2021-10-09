//
//  CharactersScreen.swift
//  Harry Potter DB
//
//  Created by Russell Gordon on 2021-10-07.
//

import SwiftUI

struct CharactersScreen: View {

    // Source of truth for the view model – initial instance
    @StateObject private var vm = CharactersViewModelImplementation(
        service: CharacterServiceImplementation()
    )

    var body: some View {

        Group {

            if vm.characters.isEmpty {
                LoadingView(text: "Fetching characters")
            } else {
                List {

                    // Display the list of characters
                    ForEach(vm.characters, id: \.name) { item in

                        CharacterView(item: item)

                    }

                }
            }

        }
        .task {
            // Wait for the quotes to be retrieved from the API
            await vm.getCharacters()
        }

    }

}

struct CharactersScreen_Previews: PreviewProvider {
    static var previews: some View {
        CharactersScreen()
    }
}
