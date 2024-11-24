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
    @ObservedObject var presenter:HomePresenter
    private let favProvider: FavProvider = {return FavProvider()}()
    
    init(isHomeScreen: Bool, presenter:HomePresenter) {
        self.isHomeScreen = isHomeScreen
        self.presenter = presenter
    }
    
    var body: some View {
        if(isHomeScreen){
            List(self.presenter.game){game in
                NavigationLink{
                    GameDetailView(id: game.id)
                } label: {
                    GameRow(game: game)
                }
            }
            .frame(maxWidth: .infinity)
            .listStyle(GroupedListStyle())
            .onAppear{
                if(self.game.count == 0){
                    presenter.getHomeData()
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
    
    //TODO: 
    private func getFavGame(){
        favProvider.getAllFavGame(){game in
            gameFav = game
        }
    }
}
