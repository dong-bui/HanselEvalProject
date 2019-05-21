//
//  GlobalConstants.swift
//  HanselEvalProject
//
//  Created by Max on 11/16/18.
//  Copyright © 2018 Hansel. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // Active and Deactive Segment Colors
    static let ACTIVE_SEGMENT_TEXT_COLOR = UIColor(rgb: 0x2D3A4B)
    static let DEACTIVE_SEGMENT_TEXT_COLOR = UIColor(rgb: 0xB5B5B5)
    static let ACTIVE_SEGMENT_CIRCLE_COLOR = UIColor(rgb: 0x00CCB3)
    static let DEACTIVE_SEGMENT_CIRCLE_COLOR = UIColor(rgb: 0xEAEAEA)
    
    // Follow & Unfollow Color
    static let FOLLOW_COLOR = UIColor(rgb: 0x00CCB3)
    static let UNFOLLOW_COLOR = UIColor(rgb: 0xBBC6CE)
    
    // Convenience Method that returns UIColor from RGB values
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    // Convenience Method that returns UIColor from Hexadecimal value
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

// MARK: String Constants
extension String {
    // ViewController Storyboard Identifiers in Dashboard Storyboard
    static let IDENTIFIER_PLACES_VIEWCONTROLLER = "PlacesViewController"
    static let IDENTIFIER_FAVORITES_VIEWCONTROLLER = "FavoritesViewController"
    static let IDENTIFIER_FRIENDS_VIEWCONTROLLER = "FriendsViewController"
    
    // UITableViewCell Identifiers
    static let IDENTIFIER_PLACES_TABLEVIEWCELL = "PlacesTableViewCell"
    static let IDENTIFIER_FRIENDS_TABLEVIEWCELL = "FriendsTableViewCell"
}
