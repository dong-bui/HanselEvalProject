//
//  Place.swift
//  HanselEvalProject
//
//  Created by Max on 11/16/18.
//  Copyright © 2018 Hansel. All rights reserved.
//

import UIKit

struct Place {
    
    var placeName: String?
    var placeImageURL: String?
    var numSpots: Int = 0
    
    // Constructor
    init(placeImageURL: String? = "", placeName: String?, numSpots: Int = 0) {
        self.placeImageURL = placeImageURL
        self.placeName = placeName
        self.numSpots = 0
    }
    
    // This matches property names with the json keys
    enum CodingKeys: String, CodingKey {
        case placeName = "location"
        case placeImageURL = "image_url"
        case numSpots = "spots"
    }
}

extension Place: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(placeName, forKey: .placeName)
        try container.encode(placeImageURL, forKey: .placeImageURL)
        try container.encode(numSpots, forKey: .numSpots)
    }
}

extension Place: Decodable {
    // Initializer
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        placeName = try values.decode(String.self, forKey: .placeName)
        placeImageURL = try values.decode(String.self, forKey: .placeImageURL)
        numSpots = try values.decode(Int.self, forKey: .numSpots)
    }
    
    // Parse Json data into Object Array
    static func decodeFromJson(filename fileName: String) -> [Place]? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let placeArray = try decoder.decode([Place].self, from: data)
            return placeArray
        } catch {
            print("JSON parsing error:\(error)")
        }
        return nil
    }
}
