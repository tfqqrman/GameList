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
    private let favProvider: FavProvider = {return FavProvider()}()
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
        let network = NetworkService()
        do {
              game = try await network.getGame()
            } catch {
              fatalError("Error: connection failed.")
            }
    }
    
    private func getFavGame(){
        favProvider.getAllFavGame(){game in
            gameFav = game
        }
    }
}
