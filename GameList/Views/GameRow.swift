//
//  GameRow.swift
//  GameList
//
//  Created by Taufiq Qurohman on 03/12/23.
//

import SwiftUI

struct GameRow: View {
    @Binding var game:Game
    @State private var isLoading: Bool = true
    @State private var loadedImage:UIImage?
    
    
    var body: some View {
        HStack{
            if let gameImage = loadedImage {
                Image(uiImage: gameImage)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: 100, height: 100)
                    .cornerRadius(15.0)
                    .padding(.leading, 5.0)
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
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text(game.name)
                        .bold()
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    
                    Text("Release Date: \(getJustDate(date:game.released))")
                        .font(.footnote)
                        .font(.system(size: 1))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    Text("Rating:\(game.rating.cleanValue)")
                        .font(.footnote)
                        .font(.system(size: 1))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
        }
        
    }
    
    
    
    func getJustDate(date:Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
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
}

extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
