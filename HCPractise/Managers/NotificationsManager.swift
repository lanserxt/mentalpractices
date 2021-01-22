//
//  NotificationsManager.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 22.01.2021.
//

import UIKit

class NotificationManager: NSObject {
    
    // Singleton
    static let shared = NotificationManager()
        
    fileprivate override init() {
        super.init()
    }
    
    func showMessage(title: String, text: String, cancelTitle: String?, actions: Array<UIAlertAction>?) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        
        if let cancelTitle = cancelTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
        }
        
        if let topViewController = ViewController.topViewController {
            if topViewController.presentedViewController == nil && !(topViewController is UIAlertController) {
                topViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func showError(_ errorText: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: errorText, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        if let topViewController = ViewController.topViewController {
            if topViewController.presentedViewController == nil && !(topViewController is UIAlertController) {
                topViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
}
