//
//  File.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/09/24.
//

import Foundation
import SwiftUI

protocol ProfileRepositoryProtocol{
    func getProfileData() -> UserEntity
}
