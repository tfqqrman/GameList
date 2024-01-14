//
//  GameDetailView.swift
//  GameList
//
//  Created by Taufiq Qurohman on 03/12/23.
//

import SwiftUI

struct GameDetailView: View {
    @Binding var game: Game
    @State var loadedImage:UIImage?
    @State var detailGame:DetailGame?
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack{
            Text(game.name)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                .font(.title.bold())
            
            if let image = loadedImage {
                Image(uiImage: image)
                    .resizable()
                    .frame(width: 300,height: 300)
                    .cornerRadius(20.0)
            } else {
                if isLoading{
                    ProgressView()
                        .onAppear {
                            Task {
                                await getImage(game: game)
                                isLoading = false
                            }
                        }
                }
            }
            
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    if let det = detailGame{
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
                    
                }
                .padding(.horizontal, 20.0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
            
        }
        .onAppear{
            Task{
                await getDetail(id:game.id)
            }
        }
    }
    
    func getImage(game:Game) async{
        let imageDownloader = ImageDownloader()
        var imageResult:UIImage
        do{
            imageResult = try await imageDownloader.downloadImage(url: game.background_image)
            game.img = imageResult
            game.state = .downloaded
            loadedImage = imageResult
        } catch {
            game.state = .failed
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
}
