//
//  GameList.swift
//  GameList
//
//  Created by Taufiq Qurohman on 03/12/23.
//

import SwiftUI

struct GameList: View {
    @State var game: [Game] = []
    //TODO: DOWNLOAD JSON DATA AND PASS IT HERE
    var body: some View {
        List($game){game in
            NavigationLink{
                GameDetailView()
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
    }
    
    func getGames() async{
        let network = NetworkService()
        do {
              game = try await network.getGame()
            } catch {
              fatalError("Error: connection failed.")
            }
    }
}

struct GameList_Previews: PreviewProvider {
    static var previews: some View {
        GameList()
    }
}
