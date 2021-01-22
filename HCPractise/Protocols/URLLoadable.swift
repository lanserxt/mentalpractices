//
//  URLLoadable.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import Foundation

protocol URLLoadable {
    var url: String {get}
    
    var loadURL: URL? {get}
}

extension URLLoadable {
    var loadURL: URL? {
        URL(string: url)
    }
}


