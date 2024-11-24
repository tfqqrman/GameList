//
//  API.swift
//  GameList
//
//  Created by Taufiq Qurohman on 09/09/24.
//

import Foundation

struct API {
  static let baseUrl = "https://api.rawg.io/api/"
  static let pageSize = 10
  static let apiKey = "002b705bebc5484aa0867a3d6e6623a7"
  static let urlParam = ["key":"\(apiKey)", "page_size":"\(pageSize)"]
}

protocol Endpoint {
    var url: String { get }
    var parameters: [String: String] { get }
}

enum Endpoints: Endpoint {
    case games, detail
    
    var url: String {
        switch self {
        case .games:
            return "\(API.baseUrl)games?"
            
        case .detail:
            return "\(API.baseUrl)games/"
        }
    }
    
    var parameters: [String : String] {
        switch self {
        case .games:
            return ["key":"\(API.apiKey)", "page_size":"\(API.pageSize)"]
        case .detail:
            return ["key":"\(API.apiKey)"]
        }
    }
}
