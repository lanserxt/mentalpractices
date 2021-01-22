//
//  AppDelegate.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var mainCoordinator: MainCoordinator?
    private var practicesVC: PracticesViewController?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupCoordinator()
        return true
    }
    
    fileprivate func setupCoordinator() {
        let practicesVC = PracticesViewController.instantiate()
        let mainNavVC = CoordinatedNavigationController.init(rootViewController: practicesVC)
        mainCoordinator = MainCoordinator(navigationController: mainNavVC)
        practicesVC.coordinator = mainCoordinator
        self.practicesVC = practicesVC
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNavVC
        window?.makeKeyAndVisible()
    }


}

