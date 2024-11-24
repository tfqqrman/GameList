//
//  DetailInteractor.swift
//  GameList
//
//  Created by Taufiq Qurohman on 10/11/24.
//
 
import Foundation

protocol DetailUseCase{
    func fetchDetail(with id: Int, completion: @escaping (Result<DetailResponse, Error>) -> Void)
}

class DetailInteractorImpl: DetailUseCase{
    private let detailRepository: GameRepositoryProtocol
    
    init(detailRepository: GameRepositoryProtocol) {
        self.detailRepository = detailRepository
    }
    
    func fetchDetail(with id: Int, completion: @escaping (Result<DetailResponse, Error>) -> Void) {
        detailRepository.getDetails(id: id) { detailResponse in
            completion(detailResponse)
        }
    }
}
