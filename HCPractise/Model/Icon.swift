//
//  Icon.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import Foundation

struct Icon: Codable, URLLoadable {
    let id: Int
    let type: String
    let title: String
    let url: String
}
