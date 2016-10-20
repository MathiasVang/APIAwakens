//
//  Protocols.swift
//  SingleViewAppSwift2Template
//
//  Created by Mathias Vang Rasmussen on 19/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

typealias Result = [[String : AnyObject]]

protocol ObjectType {}

protocol DataProtocol {
    var type: ObjectType { get }
    var name: String { get }
    init?(resultDecoder result: JSON)
}

protocol JSONDecodable {
    init?(JSON: [String : AnyObject])
}



final class StarWarsHold: JSONDecodable {
    var count: Int?
    var next: String?
    var previous: String?
    var result: Result?
    var people: [StarWarsCharacter] = []
    var vehicles: [StarWarsVehicle] = []
    var starships: [StarWarsStarship] = []
    
    init?(JSON: [String : AnyObject]) {
        
        if let count = JSON["count"] as? Int {
            self.count = count
        } else {
            self.count = nil
        }
        
        if let next = JSON["next"] as? String {
            self.next = next
        } else {
            self.next = nil
        }
        
        if let previous = JSON["previous"] as? String {
            self.previous = previous
        } else {
            self.previous = nil
        }
        
        guard let result = JSON["results"] as? Result else {
            print("Failed")
            return nil
        }
        
        self.result = result
    }
}
