//
//  DetailPresenter.swift
//  GameList
//
//  Created by Taufiq Qurohman on 10/11/24.
//

import Foundation
import SwiftUI

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase
    @Published var detail: DetailGame?
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func getDetails(id: Int) {
        detailUseCase.fetchDetail(with: id) { detailResponse in
            switch detailResponse {
                case .success(let detail):
                let formattedDescription = self.convertHTMLToAttributedString(htmlText: detail.description)
                let publisherName = detail.publishers.map{x in
                    return x.name
                }
                
                DispatchQueue.main.async {
                    self.detail = DetailGame(description: formattedDescription!,
                                             originalName: detail.originalName,
                                             playtime: detail.playtime,
                                             publisherName: publisherName.first ?? "[FAILED TO LOAD]",
                                             id: detail.id,
                                             name: detail.name,
                                             released: detail.released,
                                             backgroundImage: detail.backgroundImage,
                                             rating: detail.rating)
                }
            case .failure(_):
                break
            }
        }
    }
    
    private func convertHTMLToAttributedString(htmlText: String) -> String? {
        do {
            let data = htmlText.data(using: .utf8)
            if let data = data {
                let attributedString = try NSAttributedString(data: data,
                                                              options: [
                                                                .documentType: NSAttributedString.DocumentType.html,
                                                                .characterEncoding: String.Encoding.utf8.rawValue
                                                              ],
                                                              documentAttributes:nil)
                return attributedString.string
            }
        } catch {
            print("Error converting HTML to NSAttributedString: \(error)")
        }
        return nil
    }
}
