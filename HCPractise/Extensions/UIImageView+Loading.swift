//
//  UIImageView+Loading.swift
//  HCPractise
//
//  Created by Anton Gubarenko on 22.01.2021.
//

import UIKit
import Kingfisher

extension UIImageView {
    @discardableResult func loadUrl(_ url: URL, placeholder: UIImage = UIImage(named: "placeholder")!) -> DownloadTask? {
        self.kf.indicatorType = .activity
        return self.kf.setImage(
            with: Source.network(ImageResource(downloadURL: url)),
            placeholder: placeholder,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
