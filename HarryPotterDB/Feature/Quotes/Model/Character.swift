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

// A sub-object contained in the JSON above describes a character's wand, for example:
/*
 
 "wand":{
    "wood":"holly",
    "core":"phoenix feather",
    "length":11
 },
 
 */
// So, we create a structure to match that sub-object, which will be used in the parent structure
struct Wand: Decodable {
    let wood: String
    let core: String
    let length: Int
}

// Define a structure to match contents of the response
// NOTE: Property names in structure must exactly match properties in JSON response
struct Character: Decodable {
    let name: String
    // Since the value for this property in the JSON response is an array (denoted by the [ and ] square brackets) we make the property type in Swift an array of strings, i.e.: [String]
    let alternate_names: [String]
    let gender: String
    let dateOfBirth: String
    let yearOfBirth: Int
    let wizard: Bool
    let ancestry: String
    let eyeColour: String
    let hairColour: String
    // Use the sub-type created above on line 65
    let wand: Wand
    let patronus: String
    let hogwartsStudent: Bool
    let hogwartsStaff: Bool
    let actor: String
    let alternate_actors: [String]
    let alive: Bool
    let image: String
}

extension Character {
    
    static let dummyData: [Character] = [
    
        Character(name: "Harry Potter",
                  alternate_names: [""],
                  gender: "male",
                  dateOfBirth: "31-07-1980",
                  yearOfBirth: 1980,
                  wizard: true,
                  ancestry: "half-blood",
                  eyeColour: "green",
                  hairColour: "black",
                  wand: Wand(wood: "holly",
                             core: "phoenix feather",
                             length: 11),
                  patronus: "stag",
                  hogwartsStudent: true,
                  hogwartsStaff: false,
                  actor: "Daniel Radcliffe",
                  alternate_actors: [""],
                  alive: true,
                  image: "http://hp-api.herokuapp.com/images/harry.jpg")

    ]
    
}
