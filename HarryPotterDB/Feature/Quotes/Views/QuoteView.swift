//
//  QuoteView.swift
//  SwiftUI Starter
//
//  Created by Russell Gordon on 2021-10-07.
//

import SwiftUI

struct QuoteView: View {

    // Inject model into the view as a property
    let item: Quote
    
    var body: some View {
        VStack(alignment: .leading,
               spacing: 8) {
            
            HStack {
                
                Image(systemName: "tv")
                    .font(.system(size: 12, weight: .black))
                
                Text(item.anime)
                
            }
            
            Text(makeAttributedString(title: "Character", label: item.character))
            Text(makeAttributedString(title: "Quotes", label: item.quote))
                .lineLimit(2)
            
        }
       .padding()
       .foregroundColor(.black)

    }
    
    // Allows us to format string differently in different parts
    private func makeAttributedString(title: String, label: String) -> AttributedString {
        
        var string = AttributedString("\(title): \(label)")
        string.foregroundColor = .black
        string.font = .system(size: 16, weight: .bold)
        
        if let range = string.range(of: label) {
            string[range].foregroundColor = .black.opacity(0.8)
            string[range].font = .system(size: 16)
            string[range].foregroundColor = .red
        }
        
        return string
        
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView(item: Quote.dummyData.first!)
    }
}
