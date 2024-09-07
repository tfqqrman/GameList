//
//  Injection.swift
//  GameList
//
//  Created by Taufiq Qurohman on 07/09/24.
//

import Foundation

final class Injection{
    private func provideDataSource() -> ProfileDataSourceProtocol {
        return ProfileDataSource()
    }
    
    private func provideRepo() -> ProfileRepositoryProtocol {
        let profileDataSource = provideDataSource()
        return ProfileRepository(dataSource: profileDataSource)
    }
    
    func provideUseCase() -> ProfileUseCase {
        let profileRepository = provideRepo()
        return ProfileInteractor(profileRepository: profileRepository)
    }
}
