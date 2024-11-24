//
//  ProfileDataSource.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/09/24.
//

import Foundation
import SwiftUI

class ProfileDataSource: ProfileDataSourceProtocol {
    func getProfileData() -> UserEntity {
        return UserEntity(tittle: "Your Profile",
                          userImage: Image("profile-image"),
                          profileName: "Taufiq Qurohman",
                          userAddress: "Bekasi, Jawa Barat"
        )
    }
    
    
}
