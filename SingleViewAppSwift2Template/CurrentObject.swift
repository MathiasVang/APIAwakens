//
//  CurrentObject.swift
//  SingleViewAppSwift2Template
//
//  Created by Mathias Vang Rasmussen on 19/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct CurrentCharacter: Character {
    let yearOfBirth: String
    let height: String
    let home: String
    let eyes: String
    let hair: String
}

struct CurrentVehicle: Vehicles {
    var make: String
    var length: String
    var cost: String
    var crew: String
    var type: String
}

struct CurrentStarship: Starships {
    var make: String
    var length: String
    var cost: String
    var crew: String
    var type: String
}

extension CurrentCharacter: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let yearOfBirth = JSON["birth_year"] as? String,
            height = JSON["height"]as? String,
            home = JSON["homeworld"]as? String,
            eyes = JSON["eye_color"]as? String,
            hair = JSON["hair_color"] as? String else {
                return nil
        }
        
        self.yearOfBirth = yearOfBirth
        self.height = height
        self.home = home
        self.eyes = eyes
        self.hair = hair
    }
}

extension CurrentVehicle: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let make = JSON["manufacturer"] as? String,
            length = JSON["length"] as? String,
            cost = JSON["cost_in_credits"] as? String,
            crew = JSON["crew"] as? String,
            type = JSON["vehicle_class"] as? String else {
                return nil
        }
        
        self.make = make
        self.length = length
        self.cost = cost
        self.crew = crew
        self.type = type
    }
}

extension CurrentStarship: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let make = JSON["manufacturer"] as? String,
            length = JSON["length"] as? String,
            cost = JSON["cost_in_credits"] as? String,
            crew = JSON["crew"] as? String,
            type = JSON["starship_class"] as? String else {
                return nil
        }
        
        self.make = make
        self.length = length
        self.cost = cost
        self.crew = crew
        self.type = type
    }
}
