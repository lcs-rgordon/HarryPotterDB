//
//  Character.swift
//  Harry Potter DB
//
//  Created by Russell Gordon on 2021-10-07.
//

import Foundation

// Endpoint is:
//
//      http://hp-api.herokuapp.com/api/characters
//
// Provides a list of all Harry Potter characters.

// Example response is (of course there would be more characters in the real response):
/*
 
 [
    {
       "name":"Harry Potter",
       "alternate_names":[
          ""
       ],
       "species":"human",
       "gender":"male",
       "house":"Gryffindor",
       "dateOfBirth":"31-07-1980",
       "yearOfBirth":1980,
       "wizard":true,
       "ancestry":"half-blood",
       "eyeColour":"green",
       "hairColour":"black",
       "wand":{
          "wood":"holly",
          "core":"phoenix feather",
          "length":11
       },
       "patronus":"stag",
       "hogwartsStudent":true,
       "hogwartsStaff":false,
       "actor":"Daniel Radcliffe",
       "alternate_actors":[
          ""
       ],
       "alive":true,
       "image":"http://hp-api.herokuapp.com/images/harry.jpg"
    }
 ]
    
 
 */


// Define a structure to match contents of the response
// NOTE: Property names in structure must exactly match properties in JSON response
// NOTE: Properties that you do not want to decode can be omitted
struct Character: Decodable {
    
    let name: String
    let gender: String
    let dateOfBirth: String
    let wizard: Bool
    let ancestry: String
    let eyeColour: String
    let hairColour: String
    // Use the sub-type created below on line 91
    let wand: Wand
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    // Since the value for this property in the JSON response is an array (denoted by the [ and ] square brackets) we make the property type in Swift an array of strings, i.e.: [String]
    let alternate_actors: [String]
    let alive: Bool
    let image: String
    
}

// A sub-object contained in the JSON above describes a character's wand, for example:
/*
 
 "wand":{
    "wood":"holly",
    "core":"phoenix feather",
    "length":11
 },
 
 */
// So, we create a structure to match that sub-object, which will is used in the parent structure
struct Wand: Decodable {
    
    let wood: String
    let core: String
    let length: String
    
    // Regular initializer
    init(wood: String, core: String, length: String) {
        self.wood = wood
        self.core = core
        self.length = length
    }

    // Discovered that the API returns inconsistent values for the length of a wand 😕
    // Sometimes the API returns an empty string, sometimes an integer, and sometimes a value that includes decimals.
    //
    // That creates errors like this one.
    //
    // typeMismatch(Swift.Int, Swift.DecodingError.Context(codingPath: [_JSONKey(stringValue: "Index 1", intValue: 1), CodingKeys(stringValue: "wand", intValue: nil), CodingKeys(stringValue: "length", intValue: nil)], debugDescription: "Expected to decode Int but found a string/data instead.", underlyingError: nil))
    //
    // So, we have to manually tell Swift how to decode from JSON into an instance of this structure using a special initializer.
    init(from decoder: Decoder) throws {
        
        // This tells the compiler what JSON keys to decode
        // All keys listed will be decoded
        enum CodingKeys: CodingKey {
            case wood, core, length
        }
        
        // Creates a container to temporarily hold the values decoded from JSon
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode the wand's wood type
        self.wood = try container.decode(String.self, forKey: .wood)
        
        // Decode the wand's core type
        self.core = try container.decode(String.self, forKey: .core)
        
        // Try to decode the wand's length as a String...
        do {
            self.length = try container.decode(String.self, forKey: .length)
        } catch {
            // OK, this means the the value given by the endpoint was not a string
            // Based on revieing the data sent by the endpoint, the other possibility is that the value is sent as numeric value
            // Decode as a Double instead
            let length = try container.decode(Double.self, forKey: .length)
            
            // Now convert the Double before storing in the length property of this structure
            self.length = String(length)
            
        }
        
        
    }

}

extension Character {
    
    static let dummyData: [Character] = [
    
        Character(name: "Harry Potter",
                  gender: "male",
                  dateOfBirth: "31-07-1980",
                  wizard: true,
                  ancestry: "half-blood",
                  eyeColour: "green",
                  hairColour: "black",
                  wand: Wand(wood: "holly",
                             core: "phoenix feather",
                             length: "11"),
                  patronus: "stag",
                  hogwartsStudent: true,
                  hogwartsStaff: false,
                  actor: "Daniel Radcliffe",
                  alternate_actors: [""],
                  alive: true,
                  image: "http://hp-api.herokuapp.com/images/harry.jpg")

    ]
    
}
