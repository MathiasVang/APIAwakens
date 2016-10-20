//
//  Character.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 19/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

class StarWarsCharacter: DataProtocol {
    var type: ObjectType = StarWarsType.character
    var name: String
    var yearOfBirth: String
    var home: String
    var height: String
    var eyes: String
    var hair: String
    
    required init?(resultDecoder result: JSON) {
        guard let
            name = result["name"] as? String,
            yearOfBirth = result["birth_year"] as? String,
            height = result["height"] as? String,
            eyes = result["eye_color"] as? String,
            hair = result["hair_color"] as? String,
            home = result["homeworld"] as? String
            else {
                return nil
        }
        
        self.name = name
        self.yearOfBirth = yearOfBirth
        self.home = home
        self.height = height
        self.eyes = eyes
        self.hair = hair
    }
}
