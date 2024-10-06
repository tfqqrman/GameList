//
//  Injection.swift
//  GameList
//
//  Created by Taufiq Qurohman on 07/09/24.
//

import Foundation

final class Injection{
    ///Profile DI
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
    
    /// Home DI
    private func provideHomeRepo() -> GameRepositoryProtocol{
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance
        let local: LocalDataProvider = {return LocalDataProvider()}()
        
        return GameRepository.sharedInstance(remote, local)
    }
    
    func provideHomeUseCase() -> HomeUseCase {
        let homeRepo = provideHomeRepo()
        return HomeInteractor(homeRepo: homeRepo)
    }
}
