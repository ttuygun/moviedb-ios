//
//  MovieItemCollectionViewCell.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import UIKit
import Kingfisher

class PosterItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bindMovie(_ viewModel: MovieItemViewModel) {
        titleLabel.text = viewModel.title
        posterImage.kf.setImage(with: viewModel.posterPathURL)
    }

    func bindTVShow(_ viewModel: TVShowItemViewModel) {
        titleLabel.text = viewModel.title
        posterImage.kf.setImage(with: viewModel.posterPathURL)
    }
}
