//
//  HomeInteractor.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/10/24.
//

import Foundation
import SwiftUI

protocol HomeUseCase{
    func getHomeData() -> [Game]
}

class HomeInteractor: HomeUseCase{
    private let homeRepo: GameRepositoryProtocol
    var game: [Game] = []

    init(homeRepo: GameRepositoryProtocol) {
        self.homeRepo = homeRepo
    }
    
    func getHomeData() -> [Game] {
        homeRepo.getGame { game in
            switch game{
            case .success(let gameModel):
                self.game = gameModel.map({ gameListResult in
                    Game(id: gameListResult.id,
                         name: gameListResult.name,
                         released: gameListResult.released,
                         rating: gameListResult.rating,
                         background_image: gameListResult.background_image)
                })
            case .failure(_): break
            }
        }
        return self.game
    }
    
}
