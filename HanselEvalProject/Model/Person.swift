//
//  Person.swift
//  HanselEvalProject
//
//  Created by Max on 11/16/18.
//  Copyright © 2018 Hansel. All rights reserved.
//

import UIKit

struct Person {
    
    var profileImageURL: String?
    var fullName: String?
    var userName: String?
    var isFollowing: Bool = false
    
    // Constructor
    init(profileImageURL: String? = "", fullName: String?, userName: String?, isFollowing: Bool = false) {
        self.profileImageURL = profileImageURL
        self.fullName = fullName
        self.userName = userName
        self.isFollowing = isFollowing
    }
    
    // This matches property names with the json keys
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case userName = "user_name"
        case profileImageURL = "image_url"
        case isFollowing = "is_following"
    }
}

extension Person: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(userName, forKey: .userName)
        try container.encode(profileImageURL, forKey: .profileImageURL)
        try container.encode(isFollowing, forKey: .isFollowing)
    }
}

extension Person: Decodable {
    // Initializer
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fullName = try values.decode(String.self, forKey: .fullName)
        userName = try values.decode(String.self, forKey: .userName)
        profileImageURL = try values.decode(String.self, forKey: .profileImageURL)
        isFollowing = try values.decode(Bool.self, forKey: .isFollowing)
    }
    
    // Parse Json data into Object Array
    static func decodeFromJson(filename fileName: String) -> [Person]? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let personArray = try decoder.decode([Person].self, from: data)
            return personArray
        } catch {
            print("JSON parsing error:\(error)")
        }
        return nil
    }
}
