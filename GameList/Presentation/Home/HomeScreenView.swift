//
//  HomeScreenView.swift
//  GameList
//
//  Created by Taufiq Qurohman on 02/10/23.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var game: [Game] = []
    private let homePresetnter = HomePresenter(homeUseCase: Injection.init().provideHomeUseCase())
    var body: some View {
        TabView{
            NavigationView{
                VStack{
                    GameList(isHomeScreen: true, presenter: homePresetnter)
                        .padding(.top, 50.0)
                        .overlay(
                            ZStack{
                                Color.clear
                                    .background(.ultraThinMaterial)
                                    .blur(radius: 5)
                                HStack {
                                    Text("GAME LIST")
                                        .font(.title.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(20)
                                }
                            }
                                .frame(height: 49)
                                .frame(maxHeight: .infinity, alignment: .top)
                    )
                }
                .padding(.top, 5)
            }
            .tabItem{
                Label("Lib", systemImage: "books.vertical")
            }
            
            FavouriteScreenView()
                .tabItem{
                    Label("Favourite", systemImage: "heart.fill")
                }

            DetailProfile()
                .tabItem{
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
