//
//  Coordinator.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: CoordinatedNavigationController { get set }
    func navBack(animated: Bool)
    func navBackToRoot()
}

extension Coordinator {
    func navBack(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func navBackToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
}
