//
//  ProfilePresenter.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/09/24.
//

import Foundation
import SwiftUI

class ProfilePresenter: ProfilePresenterProtocol{
    private let profileUseCase: ProfileUseCase
    init(profileUseCase: ProfileUseCase) {
        self.profileUseCase = profileUseCase
    }
    func getProfileData() -> UserEntity {
        profileUseCase.getProfileData()
    }
}
