//
//  Storyboarded.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
}

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    // Creates a view controller from our storyboard. This relies on view controllers having the same storyboard identifier as their class name. This method shouldn't be overridden in conforming types.
    static func instantiate(_ storyboard: Storyboard = .main ) -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        
        // swiftlint:disable:next force_cast
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
