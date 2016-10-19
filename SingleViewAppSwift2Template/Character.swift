//
//  Character.swift
//  SingleViewAppSwift2Template
//
//  Created by Mathias Vang Rasmussen on 19/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

class StarWarsCharacter: Character {
    var yearOfBirth: String
    var home: String
    var height: String
    var eyes: String
    var hair: String
    
    init(yearOfBirth: String, home: String, height: String, eyes: String, hair: String) {
        self.yearOfBirth = yearOfBirth
        self.home = home
        self.height = height
        self.eyes = eyes
        self.hair = hair
    }
}
