//
//  RemoteDataSource.swift
//  GameList
//
//  Created by Taufiq Qurohman on 08/09/24.
//

import Foundation
import Alamofire

protocol RemoteDataSourceProtocol:AnyObject {
    func getListOfGame(result: @escaping (Result<[GameListResult], URLError>) -> Void)
}

final class RemoteDataSource:NSObject{
    override init (){}
    
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getListOfGame(result: @escaping (Result<[GameListResult], URLError>) -> Void) {
        guard let url = URL(string: Endpoints.games.url) else {return}
        let param = Endpoints.games.parameters
        
        AF.request(url, parameters: param)
            .validate()
            .responseDecodable(of: GameListResponse.self){response in
            switch response.result{
            case .success(let value):
                result(.success(value.results))
            case .failure:
                break
            }
        }
    }
}
