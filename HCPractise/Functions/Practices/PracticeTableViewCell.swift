//
//  PracticeTableViewCell.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 22.01.2021.
//

import UIKit
import Kingfisher

final class PracticeTableViewCell: UITableViewCell {
    
    /// Task to start/cancel iamge load on reuse
    private var imageLoadTask: DownloadTask?
    
    @IBOutlet private(set) weak var titleLbl: UILabel!
    @IBOutlet private(set) weak var subTitleLbl: UILabel!
    @IBOutlet private(set) weak var logoView: UIImageView! {
        didSet{
            logoView.backgroundColor = .clear
            logoView.image = UIImage(named: "placeholder")
        }
    }
    
    var practice: Practice? {
        didSet {
            guard let practice = practice else {return}
            titleLbl.text = practice.title
            subTitleLbl.text = practice.subtitle
            if let iconUrl = practice.icon.loadURL {
                self.imageLoadTask = logoView.loadUrl(iconUrl)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageLoadTask?.cancel()
        logoView.image = UIImage(named: "placeholder")!
    }
}
