//
//  FaceoutItem.swift
//  FaceoutTests
//
//  Created by Bryan Morfe on 5/7/22.
//

import Foundation
import UIKit

struct FaceoutItem: Hashable {
    var imageURL: URL
    var itemID: String
    var title: String
    var priceString: String
    var orientation: UIImage.Orientation = .landscape
    
    static func ==(lhs: FaceoutItem, rhs: FaceoutItem) -> Bool {
        return lhs.itemID == rhs.itemID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(itemID)
    }
}
