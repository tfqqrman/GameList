//
//  ImageDownloader.swift
//  GameList
//
//  Created by Taufiq Qurohman on 03/12/23.
//

import Foundation
import UIKit

class ImageDownloader {
  func downloadImage(url: URL) async throws -> UIImage {
    async let imageData: Data = try Data(contentsOf: url)
    return UIImage(data: try await imageData)!
  }
}
