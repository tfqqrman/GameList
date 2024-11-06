//
//  HomeInteractor.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/10/24.
//

import Foundation
import SwiftUI

protocol HomeUseCase{
    func getHomeData(result: @escaping(Result<[GameListResult],Error>) -> Void)
}

class HomeInteractor: HomeUseCase{
    private let homeRepo: GameRepositoryProtocol
    
    init(homeRepo: GameRepositoryProtocol) {
        self.homeRepo = homeRepo
    }
    
    func getHomeData(result: @escaping (Result<[GameListResult], any Error>) -> Void) {
        homeRepo.getGame { game in
            result(game)
        }
    }
    
}
