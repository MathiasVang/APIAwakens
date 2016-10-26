//
//  StarWarsClient.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang Rasmussen on 17/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

enum StarWars: Int, Endpoint {
    case People = 1
    case Vehicles = 2
    case Starships = 3
    
    var baseURL: NSURL {
        return NSURL(string: "http://swapi.co/api/")!
    }
    
    var path: String {
        switch self {
        case .People:
            return "people/"
        case .Vehicles:
            return "vehicles/"
        case .Starships:
            return "starships/"
        }
    }
    
    var request: NSURLRequest {
        let url = NSURL(string: path, relativeToURL: baseURL)
        return NSURLRequest(URL: url!)
    }
}

final class StarwarsAPIClient: APIClient {
    
    let configuration: NSURLSessionConfiguration
    lazy var session: NSURLSession = {
        return NSURLSession(configuration: self.configuration)
    }()
    
    init(config: NSURLSessionConfiguration) {
        self.configuration = config
    }
    
    convenience init() {
        self.init(config: NSURLSessionConfiguration.defaultSessionConfiguration())
    }
    
    func fetchDataFor(type: StarWars, customURL: NSURLRequest?, completion: APIResult<StarWarsHold> -> Void) {
        
        var request = NSURLRequest()
        if customURL == nil {
            switch type {
            case .People:
                request = StarWars.People.request
            case .Vehicles:
                request = StarWars.Vehicles.request
            case .Starships:
                request = StarWars.Starships.request
            }
        } else if customURL != nil {
            request = customURL!
        }
        
        fetch(request, parse: { json -> StarWarsHold? in
            
            guard let holder = StarWarsHold(JSON: json) else {
                print("Fail conversion")
                return nil
            }
            
            if let result = holder.results {
                for i in 0 ..< result.count {
                    switch type {
                        
                    case .People:
                        if let character = StarWarsCharacter(resultDecoder: result[i]) {
                            holder.people.append(character)
                        }
                    case .Vehicles:
                        if let vehicle = StarWarsVehicle(resultDecoder: result[i]) {
                            holder.vehicles.append(vehicle)
                        }
                    case .Starships:
                        if let starship = StarWarsStarship(resultDecoder: result[i]) {
                            holder.starships.append(starship)
                        }
                    }
                }
            }
            
            return holder
            
            }, completion: completion)
    }
    
    func fetchSingleData(customURL: NSURLRequest, forType: StarWars, completion: APIResult<AnyObject> -> Void) {
        
        fetch(customURL, parse: { json -> AnyObject? in
            
            let holder: AnyObject?
            
            switch forType {
            case .People:
                holder = StarWarsCharacter(resultDecoder: json)
            case .Vehicles:
                holder = StarWarsVehicle(resultDecoder: json)
            case .Starships:
                holder = StarWarsStarship(resultDecoder: json)
            }
            
            return holder
            
            }, completion: completion)
    }
}
