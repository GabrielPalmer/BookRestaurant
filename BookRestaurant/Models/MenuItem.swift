//
//  MenuItem.swift
//  BookRestaurant
//
//  Created by Gabriel Blaine Palmer on 1/3/19.
//  Copyright © 2019 Gabriel Blaine Palmer. All rights reserved.
//

import Foundation

struct MenuItem: Codable {
    
    var id: Int
    var name: String
    var detailText: String
    var price: Double
    var category: String
    var imageURL: URL
    
    var printDescription: String {
        return "id: \(id)\nName: \(name)\nDescription: \(detailText)\nPrice: \(price)\nCategory: \(category)\n"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.detailText = try valueContainer.decode(String.self, forKey: CodingKeys.detailText)
        self.price = try valueContainer.decode(Double.self, forKey: CodingKeys.price)
        self.category = try valueContainer.decode(String.self, forKey: CodingKeys.category)
        let url = try valueContainer.decode(String.self, forKey: CodingKeys.imageURL)
        self.imageURL = URL(string: url)!
        
    }
}

struct IntermediateMenuItem: Decodable {
    var items: [MenuItem]
}
