//
//  PracticesDataSource.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit
import Kingfisher

protocol PracticesDataSourceDelegate: AnyObject {
    func practiceSelected(source: PracticesDataSource, practice: Practice)
}

final class PracticesDataSource: NSObject {
    
    weak var delegate: PracticesDataSourceDelegate?
    
    init(practices: [Practice]) {
        self.practices = practices
    }
    
    let practices: [Practice]
}

extension PracticesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        practices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PracticeTableViewCell.cellIdentifier, for: indexPath) as! PracticeTableViewCell
        cell.practice = practices[indexPath.row]
        return cell
    }
}

extension PracticesDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.practiceSelected(source: self, practice: practices[indexPath.row])
    }
}
