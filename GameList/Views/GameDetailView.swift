//
//  GameDetailView.swift
//  GameList
//
//  Created by Taufiq Qurohman on 03/12/23.
//

import SwiftUI

struct GameDetailView: View {
    var id: Int
    @State var loadedImage: UIImage?
    @State var detailGame: DetailGame?
    @State private var isLoading: Bool = true
    @State private var isLiked: Bool = false
    @State private var likeColor: Color = .gray
    @State private var likeString: String = "Like"

    private let favProvider: FavProvider = {return FavProvider()}()
    
    var body: some View {
        VStack{
            if let det = detailGame{
                Text(det.originalName)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20)
                    .font(.title.bold())
                if let image = loadedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 300,height: 300)
                        .cornerRadius(20.0)
                    HStack{
                        Spacer()
                        Button(action: {
                            withAnimation(nil) {
                                isLiked.toggle()
                                likeColor = isLiked ? .red : .gray
                                likeString = isLiked ? "Liked" : "Like"
                            }
                            if(isLiked){
                                saveGameAsFavourite(gameFav: det)
                            } else {
                                deleteGameFromFav(id: det.id)
                            }
                        }){
                            Text(likeString)
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(likeColor)
                        }
                        .padding(.trailing, 40)
                    }
                } else {
                    if isLoading{
                        ProgressView()
                            .onAppear {
                                Task {
                                    await getImage(game: det)
                                    isLoading = false
                                }
                            }
                    }
                }
                ScrollView{
                    VStack(alignment: .leading, spacing: 0){
                        Text("Original Name:")
                            .font(.system(size: 13, weight: .ultraLight))
                            .padding(.top, 5)
                        Text(det.originalName)
                            .lineLimit(nil)
                            .font(.title3.bold())
                        Text("Publisher:")
                            .font(.system(size: 13, weight: .ultraLight))
                            .padding(.top, 5)
                        Text(det.publisherName)
                            .lineLimit(nil)
                            .font(.title3.bold())
                        Text("Play Time:")
                            .font(.system(size: 13, weight: .ultraLight))
                            .padding(.top, 5)
                        HStack(alignment: .bottom, spacing: 2){
                            Text(String(det.playTime))
                                .lineLimit(nil)
                                .font(.title3.bold())
                            Text("hour(s)")
                                .font(.system(size: 13, weight: .light))
                        }
                        
                        Text("Description:")
                            .font(.system(size: 13, weight: .ultraLight))
                            .padding(.top, 5)
                        Text(det.description)
                            .lineLimit(nil)
                    }
                    .padding(.horizontal, 20.0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                }
            }
        }
        .onAppear{
            favProvider.isFavourite(self.id){ isGameFav in
                isLiked = isGameFav
                likeColor = isLiked ? .red : .gray
                likeString = isLiked ? "Liked" : "Like"
            }
            Task{
                await getDetail(id:self.id)
            }
        }
    }
    
    func getImage(game:DetailGame) async{
        let imageDownloader = ImageDownloader()
        var imageResult:UIImage
        do{
            imageResult = try await imageDownloader.downloadImage(url: game.backgroundImage)
            game.img = imageResult
            loadedImage = imageResult
        } catch {
            fatalError("Error: failed to download image")
        }
    }
    
    func getDetail(id:Int) async{
        let gameDetail = NetworkService()
        do {
            self.detailGame = try await gameDetail.getDetailGameInfo(id)
        } catch {
              fatalError("Error: connection failed.")
        }
    }
    
    private func saveGameAsFavourite(gameFav: DetailGame) {
        let id = gameFav.id
        let title = gameFav.name
        let rate = gameFav.rating
        let releaseDate = gameFav.released
        let image = gameFav.backgroundImage
        favProvider.saveGameToFav(id, title, releaseDate, rate, image) {}
    }
    
    private func deleteGameFromFav(id: Int){
        favProvider.deleteFavGame(id){}
    }
}
