//
//  FavouriteScreenView.swift
//  GameList
//
//  Created by Taufiq Qurohman on 04/02/24.
//

import SwiftUI

struct FavouriteScreenView: View {
    private let favProvider: FavProvider = {return FavProvider()}()
    @State var isEmpty: Bool = true
    @State var gameFav: [FavModel] = []
    @State var game: [Game] = []
    
    var body: some View {
        NavigationView{
            VStack{
                if(isEmpty){
                    Text("You have not choose your favourite game yet")
                } else {
                    GameList(isHomeScreen: false)
                        .padding(.top, 50.0)
                        .overlay(
                            ZStack{
                                Color.clear
                                    .background(.ultraThinMaterial)
                                    .blur(radius: 5)
                                HStack {
                                    Text("Your Favourite")
                                        .font(.title.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(20)
                                }
                                
                            }
                                .frame(height: 49)
                                .frame(maxHeight: .infinity, alignment: .top)
                    )
                }
                
            }
            .onAppear{
                if(favProvider.isFavEmpty()){
                    isEmpty = true
                } else {
                    isEmpty = false
                }
            }
            .padding(.top, 5)
        }
    }
}

