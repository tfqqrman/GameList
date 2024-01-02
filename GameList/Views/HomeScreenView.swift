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
            VStack{
                GameList()
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
                                NavigationLink{
                                    DetailProfile()
                                }label: {
                                    CircleImage(image: Image("profile-image"))
                                }
                                
                                    .padding(.trailing, 20)
                            }
                        }
                            .frame(height: 49)
                            .frame(maxHeight: .infinity, alignment: .top)
                )
            }
            .padding(.top, 5)
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
