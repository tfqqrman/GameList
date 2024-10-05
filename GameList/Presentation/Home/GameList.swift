//
//  GameList.swift
//  GameList
//
//  Created by Taufiq Qurohman on 03/12/23.
//

import SwiftUI
struct GameList: View {
    @State var game: [Game] = []
    @State var gameFav: [FavModel] = []
    @State private var showToast = false
    var isHomeScreen: Bool
    private let remoteDataSource = RemoteDataSource()
    private let favProvider: FavProvider = {return FavProvider()}()
    private let localDataProvider: LocalDataProvider = {return LocalDataProvider()}()
    private let gameRepo:GameRepository
    
    init(isHomeScreen: Bool) {
            self.isHomeScreen = isHomeScreen
            self.gameRepo = GameRepository.sharedInstance(remoteDataSource, localDataProvider)
        }
    
    var body: some View {
        if(isHomeScreen){
            List($game){game in
                NavigationLink{
                    GameDetailView(id: game.id)
                } label: {
                    GameRow(game: game)
                }
            }
            .frame(maxWidth: .infinity)
            .listStyle(GroupedListStyle())
            .onAppear{
                Task{
                    await getGames()
                }
            }
        } else {
            List($gameFav){game in
                NavigationLink{
                    GameDetailView(id: Int(game.id ?? 0))
                } label: {
                    FavGameRow(game: game)
                }
            }
            .frame(maxWidth: .infinity)
            .listStyle(GroupedListStyle())
            .onAppear{
                getFavGame()
            }
        }
    }
    
    
    func getGames() async{
        gameRepo.getGame { game in
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
    }
    
    private func getFavGame(){
        favProvider.getAllFavGame(){game in
            gameFav = game
        }
    }
}
