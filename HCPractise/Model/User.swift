//
//  User.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import Foundation

final class User: Codable {
    
    let id: Int
    let name: String
    let email: String
    
    init(id: Int, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
}
