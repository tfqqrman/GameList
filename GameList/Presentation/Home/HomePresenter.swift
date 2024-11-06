//
//  HomePresenter.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/10/24.
//

import Foundation
import SwiftUI



class HomePresenter: ObservableObject{
    private let homeUseCase: HomeUseCase
    @Published var game: [Game] = []
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    func getHomeData(){
        homeUseCase.getHomeData { game in
            switch game{
            case .success(let gameModel):
                DispatchQueue.main.async {
                    self.game = gameModel.map({games in
                        Game(id: games.id,
                             name: games.name,
                             released: games.released, rating: games.rating,
                             background_image: games.background_image)
                    })
                }
            case .failure(_): break
            }
            
        }
    }
}
