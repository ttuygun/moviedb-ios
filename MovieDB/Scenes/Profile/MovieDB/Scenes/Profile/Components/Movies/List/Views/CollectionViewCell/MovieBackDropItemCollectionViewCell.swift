//
//  MovieBackDropItemCollectionViewCell.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 30.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import UIKit
import Kingfisher

class MovieBackDropItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backdropImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bind(_ viewModel: MovieItemViewModel) {
        backdropImage.kf.setImage(with: viewModel.backdropPathURL)
    }

}
