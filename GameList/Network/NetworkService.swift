//
//  NetworkService.swift
//  GameList
//
//  Created by Taufiq Qurohman on 08/10/23.
//

import Foundation

class NetworkService {
    let apiKey = "002b705bebc5484aa0867a3d6e6623a7"
    let pageSize = "10"
    
    func getGame() async throws -> [Game] {
        var components = URLComponents(string: "https://api.rawg.io/api/games?")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "page_size", value: pageSize)
        ]
        
        let request = URLRequest(url: components.url!)
        let (data, response) = try await URLSession.shared.data(for:request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(GameResponses.self, from: data) //this should be the response
        print("ini adalah isi result: \(result)")
        return gameMapper(input: result.results)
    }
}

extension NetworkService{
    fileprivate func gameMapper(
        input gameResult: [GameResult]
    ) -> [Game]{
        return gameResult.map{ result in
            return Game(
                id: result.id,
                name: result.name,
                released: result.released,
                rating: result.rating,
                background_image: result.background_image
            )
        }
    }
}
