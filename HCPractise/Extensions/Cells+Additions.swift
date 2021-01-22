//
//  Cells+Additions.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit

extension UITableViewCell {
    class var cellIdentifier: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

extension UICollectionViewCell {
    
    class var cellIdentifier: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}
