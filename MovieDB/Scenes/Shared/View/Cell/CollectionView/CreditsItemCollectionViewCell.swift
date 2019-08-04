//
//  CreditsItemCollectionViewCell.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 29.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import UIKit
import Kingfisher

class CreditsItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var profileImage: SwiftShadowImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ viewModel: CreditsItemViewModel?) {
        nameLabel.text = viewModel?.name
        profileImage.imageView.kf.setImage(with: viewModel?.profileURL, placeholder: UIImage(named: "posterImage"))
        jobLabel.text = viewModel?.job

        if viewModel?.job == nil {
            jobLabel.isEnabled = false
        }
    }
}
