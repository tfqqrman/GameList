//
//  FavModel.swift
//  GameList
//
//  Created by Taufiq Qurohman on 04/02/24.
//

import Foundation

struct FavModel:Identifiable{
    var id: Int32?
    var background_image:URL?
    var name: String?
    var rating: Double?
    var released: Date?
}
