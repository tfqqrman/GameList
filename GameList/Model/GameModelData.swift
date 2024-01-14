//
//  GameModelData.swift
//  GameList
//
//  Created by Taufiq Qurohman on 08/10/23.
//

import Foundation
import UIKit

enum DownloadState {
    case new, downloaded, failed
}

class DetailGame:Identifiable{
    let description:String
    let originalName:String
    let playTime:Int
    let publisherName:String
    //TODO: ADD PUBLISHER
    
    init(description:String,
         originalName:String,
         playtime:Int,
         publisherName:String
         ) {
        self.description = description
        self.originalName = originalName
        self.playTime = playtime
        self.publisherName = publisherName
    }
}

class Game:Identifiable{
    let id:Int
    let name:String
    let released:Date
    let rating:Double
    var background_image:URL
    
    var img: UIImage?
    var state: DownloadState = .new
    
    init(id: Int,
         name: String,
         released: Date,
         rating: Double,
         background_image: URL
         ) {
        self.id = id
        self.name = name
        self.released = released
        self.rating = rating
        self.background_image = background_image
    }
}

struct GameResponses: Codable{
    let seo_title:String
    let results:[GameResult]
}

struct GameResult:Codable{
    let id:Int
    let name:String //judul
    let released:Date //tanggal release
    let rating:Double
    let background_image: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case rating
        case background_image = "background_image"
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

struct DetailResponse: Codable{
    let description:String
    let originalName:String
    let playtime:Int
    let publishers:[PublisherResult]
    
    enum CodingKeys: String, CodingKey {
        case description
        case originalName = "name_original"
        case playtime
        case publishers
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        description = try container.decode(String.self, forKey: .description)
        originalName = try container.decode(String.self, forKey: .originalName)
        playtime = try container.decode(Int.self, forKey: .playtime)
        publishers = try container.decode([PublisherResult].self, forKey: .publishers)
    }
    
}

struct PublisherResult: Codable{
    let id: Int
    let name: String
    let slug: String
    let gamesCount: Int
    let imageBackground: URL
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        slug = try container.decode(String.self, forKey: .slug)
        gamesCount = try container.decode(Int.self, forKey: .gamesCount)
        imageBackground = try container.decode(URL.self, forKey: .imageBackground)
    }
}

