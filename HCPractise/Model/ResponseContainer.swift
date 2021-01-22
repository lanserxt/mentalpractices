//
//  ResponseContainer.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit

struct ResponseContainer<T: Codable>: Codable {
    let success: Bool
    let status: Int
    let message: String
    let data: T
}
