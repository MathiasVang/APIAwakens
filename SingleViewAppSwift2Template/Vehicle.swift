//
//  Vehicle.swift
//  SingleViewAppSwift2Template
//
//  Created by Mathias Vang Rasmussen on 19/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

class StarWarsVehicle: Vehicles {
    var make: String
    var cost: String
    var crew: String
    var length: String
    var type: String
    
    init(make: String, cost: String, crew: String, length: String, type: String) {
        self.make = make
        self.cost = cost
        self.crew = crew
        self.length = length
        self.type = type
    }
}
