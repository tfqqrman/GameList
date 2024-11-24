//
//  ProfileRepository.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/09/24.
//

import Foundation
import SwiftUI

class ProfileRepository:ProfileRepositoryProtocol{
    private let profileDataSource: ProfileDataSourceProtocol
    
    init(dataSource: ProfileDataSourceProtocol) {
        self.profileDataSource = dataSource
    }
    func getProfileData() -> UserEntity {
        profileDataSource.getProfileData()
    }
}
