//
//  Test.swift
//  TheAPIAwakens
//
//  Created by Mathias Vang on 25/10/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum SpeciesFields: String {
    case Name = "name"
    case Classification = "classification"
    case Designation = "designation"
    case AverageHeight = "average_height"
    case SkinColors = "skin_colors"
    case HairColors = "hair_colors"
    case EyeColors = "eye_colors"
    case AverageLifespan = "average_lifespan"
    case Homeworld = "homeworld"
    case Language = "language"
    case People = "people"
    case Films = "films"
    case Created = "created"
    case Edited = "edited"
    case Url = "url"
}

class SpeciesWrapper {
    var species: Array<StarWarsSpecies>?
    var count: Int?
    private var next: String?
    private var previous: String?
}

class StarWarsSpecies {
    var idNumber: Int?
    var name: String?
    var classification: String?
    var designation: String?
    var averageHeight: Int?
    var skinColors: String?
    var hairColors: String?
    var eyeColors: String?
    var averageLifespan: Int?
    var homeworld: String?
    var language: String?
    var people: [String]?
    var films: [String]?
    var created: NSDate?
    var edited: NSDate?
    var url: String?
    
    required init(json: JSON, id: Int?) {
        self.idNumber = id
        self.name = json[SpeciesFields.Name.rawValue]!.stringValue
        self.classification = json[SpeciesFields.Classification.rawValue]!.stringValue
        self.designation = json[SpeciesFields.Designation.rawValue]!.stringValue
        self.averageHeight = json[SpeciesFields.AverageHeight.rawValue]!.integerValue
        self.skinColors = json[SpeciesFields.SkinColors.rawValue]!.stringValue
        self.hairColors = json[SpeciesFields.HairColors.rawValue]!.stringValue
        self.eyeColors = json[SpeciesFields.EyeColors.rawValue]!.stringValue
        self.averageLifespan = json[SpeciesFields.AverageLifespan.rawValue]!.integerValue
        self.homeworld = json[SpeciesFields.Homeworld.rawValue]!.stringValue
        self.language = json[SpeciesFields.Language.rawValue]!.stringValue
        self.created = json[SpeciesFields.Created.rawValue]!.date
        self.edited = json[SpeciesFields.Edited.rawValue]!.date
        self.url = json[SpeciesFields.Url.rawValue]!.stringValue
        
        // MARK: Endpoints
        func endpointForSpecies() -> String {
            return "https://swapi.co/api/species/"
        }
        
        private func getSpeciesAtPath(path: String, completionHandler: (SpeciesWrapper?, NSError?) -> Void) {
            // iOS 9: Replace HTTP with HTTPS
            let securePath = path.stringByReplacingOccurrencesOfString("http://", withString: "https://", options: .AnchoredSearch)
            Alamofire.request(.GET, path)
                .responseSpeciesArray { response in
                    completionHandler(response.result.value, response.result.error)
            }
        }
        
        func getSpecies(completionHandler: (SpeciesWrapper?, NSError?) -> Void) {
            getSpeciesAtPath(StarWarsSpecies.endpointForSpecies(), completionHandler: completionHandler)
        }
        
        func getMoreSpecies(wrapper: SpeciesWrapper?, completionHandler: (SpeciesWrapper?, NSError?) -> Void) {
            guard let nextPath = wrapper?.next else {
                completionHandler(nil, nil)
                return
            }
            getSpeciesAtPath(nextPath, completionHandler: completionHandler)
        }
    }
}
