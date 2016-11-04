//
//  Planet.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 04/11/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

class StarWarsPlanet: DataProtocol {
    let type: ObjectType = StarWarsType.planet
    let name: String
    
    required init?(resultDecoder result: JSON) {
        guard let name = result["name"] as? String else {
            return nil
        }
        self.name = name
    }
}
