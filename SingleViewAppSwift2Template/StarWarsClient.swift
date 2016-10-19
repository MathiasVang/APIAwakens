//
//  StarWarsClient.swift
//  SingleViewAppSwift2Template
//
//  Created by Mathias Vang Rasmussen on 17/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct ObjectID {
    let name: [[String : AnyObject]]
}

enum StarWars: Endpoint {
    case Current(token: String, id: ObjectID)
    
    var baseURL: NSURL {
        return NSURL(string: "http://swapi.co/api/")!
    }
    
    var path: String {
        switch self {
        case .Current(let token, let id):
            return "/\(token)/\(id)"
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
    
    private let token: String
    
    init(config: NSURLSessionConfiguration, APIKey: String) {
        self.configuration = config
        self.token = APIKey
    }
    
    convenience init(APIKey: String) {
        self.init(config: NSURLSessionConfiguration.defaultSessionConfiguration(), APIKey: APIKey)
    }
    
    func fetch<T>(request: NSURLRequest, parse: JSON -> T?, completion: APIResult<T> -> Void) {
    }
}
