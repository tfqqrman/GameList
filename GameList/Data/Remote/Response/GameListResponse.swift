//
//  GameListResponse.swift
//  GameList
//
//  Created by Taufiq Qurohman on 08/09/24.
//

import Foundation

struct GameListResponse: Codable{
    let seo_title: String
    let results:[GameListResult]
}

struct GameListResult: Codable{
    let id: Int
    let name: String
    let released: Date
    let rating: Double
    let background_image: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case rating
        case background_image = "background_image"
    }
    
    init(id: Int, name: String, released: Date, rating: Double, background_image: URL) {
        self.id = id
        self.name = name
        self.released = released
        self.rating = rating
        self.background_image = background_image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let imagePath = try container.decode(String.self, forKey: .background_image)
        background_image = URL(string: imagePath)!
        
        let dateReleased = try container.decode(String.self, forKey: .released)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        released = formatter.date(from: dateReleased)!
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        rating = try container.decode(Double.self, forKey: .rating)
    }
}
