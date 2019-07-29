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
    @IBOutlet weak var profileImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ viewModel: CreditsItemViewModel?) {
        nameLabel.text = viewModel?.name
        profileImage.kf.setImage(with: viewModel?.profilePath?.createFullImageURL())
        jobLabel.text = viewModel?.job
    }
}
