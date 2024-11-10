//
//  GameRepository.swift
//  GameList
//
//  Created by Taufiq Qurohman on 10/09/24.
//

import Foundation

protocol GameRepositoryProtocol {
    func getGame(result: @escaping(Result<[GameListResult], Error>) -> Void)
    func getDetails(id: Int, result: @escaping(Result<DetailResponse, Error>) -> Void)
}

final class GameRepository:NSObject{
    typealias GameInsatance = (RemoteDataSource, LocalDataProvider) -> GameRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let local: LocalDataProvider
    
    private init(remote: RemoteDataSource, local:LocalDataProvider) {
        self.remote = remote
        self.local = local
    }
    
    static let sharedInstance: GameInsatance = { remoteRepo, localRepo in
        return GameRepository(remote: remoteRepo, local: localRepo)
    }
}

extension GameRepository:GameRepositoryProtocol{
    func getGame(result: @escaping (Result<[GameListResult], any Error>) -> Void) {
        if (local.isDataEmpty()){
            remote.getListOfGame { remoteResponse in
                switch remoteResponse{
                case .success(let gamelistResponse):
                    let games = gamelistResponse
                    for game in games {
                        self.local.saveGameDataToLocal(game.id, 
                                                  game.name,
                                                  game.released,
                                                  game.rating,
                                                  game.background_image){
                        }
                    }
                    result(.success(games))
                case .failure(let error):
                    result(.failure(error))
                }
            }
        } else {
            local.getDataInLocalDataProvider { gameData in
                
                let gameListResults = gameData.compactMap { gameModel -> GameListResult? in
                    guard let id = gameModel.id,
                          let name = gameModel.name,
                          let released = gameModel.released,
                          let rating = gameModel.rating,
                          let backgroundImage = gameModel.background_image else {
                        return nil
                    }
                    return GameListResult(id: Int(id),
                                          name: name,
                                          released: released,
                                          rating: rating,
                                          background_image: backgroundImage)
                }
                
                result(.success(gameListResults))
                
            }
        }
    }
    
    func getDetails(id: Int, result: @escaping (Result<DetailResponse, any Error>) -> Void) {
        remote.getDetailOfGame(id: id) { detailResponse in
            switch detailResponse {
                case .success(let detail):
                result(.success(detail))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
