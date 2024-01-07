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
        return gameMapper(input: result.results)
    }
    
    func getDetailGameInfo(_ id:Int) async throws -> DetailGame{
        //TODO: getting the detail game information from existing API
        var components = URLComponents(string: "https://api.rawg.io/api/games/\(id)?")!
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        let request = URLRequest(url: components.url!)
        let (data, response) = try await URLSession.shared.data(for:request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error: Can't fetching data")
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(DetailResponse.self, from: data) //this should be the response
        let formattedDescription = convertHTMLToAttributedString(htmlText: result.description)
        
        return DetailGame(description: formattedDescription!, originalName: result.originalName, playtime: result.playtime)
        
    }
    
    private func convertHTMLToAttributedString(htmlText: String) -> String? {
        do {
            let data = htmlText.data(using: .utf8)
            if let data = data {
                let attributedString = try NSAttributedString(data: data,
                                                              options: [
                                                                .documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue
                                                              ],
                                                              documentAttributes:nil)
                return attributedString.string
            }
        } catch {
            print("Error converting HTML to NSAttributedString: \(error)")
        }
        return nil
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
