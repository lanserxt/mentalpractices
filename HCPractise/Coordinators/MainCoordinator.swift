//
//  MainCoordinator.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit


class MainCoordinator: Coordinator {
    var navigationController: CoordinatedNavigationController
    
    var childCoordinators = [Coordinator]()
    
    init(navigationController: CoordinatedNavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateBack() {
        self.navigationController.popViewController(animated: true)
    }
    
    func openPractice(_ practice: Practice) {
        let practiceVC = PracticeViewController.instantiate()
        practiceVC.practice = practice
        self.navigationController.pushViewController(practiceVC, animated: true)
    }
}
