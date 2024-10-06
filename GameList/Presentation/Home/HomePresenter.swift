//
//  HomePresenter.swift
//  GameList
//
//  Created by Taufiq Qurohman on 05/10/24.
//

import Foundation
import SwiftUI



class HomePresenter: ObservableObject{
    private let homeUseCase: HomeUseCase
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    func getHomeData() -> [Game] {
        homeUseCase.getHomeData()
    }
}
