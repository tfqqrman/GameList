//
//  HomeScreenView.swift
//  GameList
//
//  Created by Taufiq Qurohman on 02/10/23.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var game: [Game] = []
    var body: some View {
        NavigationView{
            GameList()
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
