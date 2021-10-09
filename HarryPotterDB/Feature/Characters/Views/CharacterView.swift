//
//  CharacterView.swift
//  Harry Potter DB
//
//  Created by Russell Gordon on 2021-10-07.
//

import SwiftUI

struct CharacterView: View {

    // Inject model into the view as a property
    let item: Character
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            Text(item.name)
                .font(.title)
                .bold()
            
            AsyncImage(url: URL(string: item.image)!) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Text(makeAttributedString(title: "Date of Birth",
                                      label: item.dateOfBirth))
            
            Text(makeAttributedString(title: "Gender",
                                      label: item.gender))
            
        }
       .padding()

    }
    
    // Allows us to format string differently in different parts
    private func makeAttributedString(title: String, label: String) -> AttributedString {
        
        var string = AttributedString("\(title): \(label)")
        string.foregroundColor = .primary
        string.font = .system(size: 16, weight: .bold)
        
        if let range = string.range(of: label) {
            string[range].foregroundColor = .black.opacity(0.8)
            string[range].font = .system(size: 16)
            string[range].foregroundColor = .primary
        }
        
        return string
        
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(item: Character.dummyData.first!)
    }
}
