//
//  ProfileDataSourceProtocol.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/09/24.
//

import Foundation
import SwiftUI

protocol ProfileDataSourceProtocol{
    func getProfileData() -> UserEntity
}
