//
//  ProfileInteractor.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/09/24.
//

import Foundation
import SwiftUI

class ProfileInteractor: ProfileUseCase{
    private let profileRepository: ProfileRepositoryProtocol
    
    init(profileRepository: ProfileRepositoryProtocol) {
        self.profileRepository = profileRepository
    }
    
    func getProfileData() -> UserEntity {
        profileRepository.getProfileData()
    }
}
