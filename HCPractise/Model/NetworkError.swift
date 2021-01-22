//
//  NetworkError.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import Foundation

struct NetworkError: Error, Codable {
    let success: Bool
    let status: Int
    let message: String
    
    var localizedDescription: String {
        message
    }
    
    init() {
        self.success = false
        self.status = -1
        self.message = "No data"
    }
    
    init(error: Error?) {
        self.success = false
        self.status = -1
        self.message = error?.localizedDescription ?? ""
    }
}
