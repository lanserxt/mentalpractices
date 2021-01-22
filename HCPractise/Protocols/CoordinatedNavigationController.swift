//
//  CoordinatedNavigationController.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit

/// A navigation controller that is aware of its coordinator. This is used extremely rarely through UIResponder-Coordinated.swift, for when we need to find the coordinator responsible for a specific view.
class CoordinatedNavigationController: UINavigationController {
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
