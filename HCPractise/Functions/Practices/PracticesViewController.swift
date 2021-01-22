//
//  PracticesViewController.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 21.01.2021.
//

import UIKit

/// Class to work with Practices
final class PracticesViewController: ViewController, MainCoordinated {
    
    var coordinator: MainCoordinator?
    let viewModel = PracticesViewModel()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = viewModel.dataSource
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserAndPractices()        
    }
    
    fileprivate func loadUserAndPractices() {
        self.showLoader()
        
        let group = DispatchGroup()
        group.enter()
        viewModel.getUserInfo {[weak self] (result) in
            group.leave()
            switch result {
            case .success():
                DispatchQueue.main.async {
                    self?.title = String(format: NSLocalizedString("Hello, %@!", comment: ""), self?.viewModel.userName ?? "")
                }
                break
            case .failure(let error):
                NotificationManager.shared.showError(error.localizedDescription)
                break
            }
        }
        
        group.enter()
        viewModel.getPractices {[weak self] (result) in
            group.leave()
            switch result {
            case .success():
                self?.tableView.dataSource = self?.viewModel.dataSource
                self?.tableView.delegate = self?.viewModel.dataSource
                self?.viewModel.dataSource.delegate = self
                self?.tableView.reloadData()
                break
            case .failure(let error):
                NotificationManager.shared.showError(error.localizedDescription)
                break
            }
        }
        group.notify(queue: DispatchQueue.main) {
            self.dismissLoader()
        }
    }
}

extension PracticesViewController: PracticesDataSourceDelegate {
    func practiceSelected(source: PracticesDataSource, practice: Practice) {
        coordinator?.openPractice(practice)
    }
}
