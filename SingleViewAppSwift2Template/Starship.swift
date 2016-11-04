//
//  Starship.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 19/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

class StarWarsStarship: DataProtocol {
    var type: ObjectType = StarWarsType.starship
    var name: String
    var make: String
    var cost: String
    var crew: String
    var length: String
    var model: String
    var vehicleClass: String
    
    required init?(resultDecoder result: JSON) {
        guard let
            name = result["name"] as? String,
            make = result["manufacturer"] as? String,
            cost = result["cost_in_credits"] as? String,
            crew = result["crew"] as? String,
            length = result["length"] as? String,
            model = result["model"] as? String,
            vehicleClass = result["starship_class"] as? String
            else {
                return nil
        }
        
        self.name = name
        self.make = make
        self.cost = cost
        self.crew = crew
        self.length = length
        self.model = model
        self.vehicleClass = vehicleClass
    }
}
