//
//  Protocols.swift
//  SingleViewAppSwift2Template
//
//  Created by Mathias Vang Rasmussen on 19/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

protocol ObjectType {}

protocol Character {
    var yearOfBirth: String { get }
    var home: String { get }
    var height: String { get }
    var eyes: String { get }
    var hair: String { get }
}

protocol Vehicles {
    var make: String { get }
    var cost: String { get }
    var length: String { get }
    var type: String { get }
    var crew: String { get }
}

protocol Starships {
    var make: String { get }
    var cost: String { get }
    var length: String { get }
    var type: String { get }
    var crew: String { get }
}
