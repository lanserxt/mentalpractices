//
//  PracticesViewModel.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 22.01.2021.
//

import UIKit

final class PracticesViewModel {
    
    private var user: User?
    private var practices: [Practice] = []
    private(set) var dataSource = PracticesDataSource(practices: [])
    
    var userName: String {
        user?.name ?? ""
    }
    
    func getUserInfo(_ completion: @escaping (Swift.Result<Void, NetworkError>) -> Void ) {
        APIManager.shared.getUser {[weak self] (result) in
            switch result {
            case .success(let user):
                self?.user = user
                completion(.success(Void()))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
    
    func getPractices(_ completion: @escaping (Swift.Result<Void, NetworkError>) -> Void ) {
        APIManager.shared.getPractices {[weak self] (result) in
            switch result {
            case .success(let practices):
                self?.practices = practices
                self?.dataSource = PracticesDataSource(practices: practices)
                completion(.success(Void()))
                break
            case .failure(let error):
                completion(.failure(error))
                break
            }
        }
    }
}
