//
//  MovieItemCollectionViewCell.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func bind(_ viewModel: MovieItemViewModel) {
        titleLabel.text = viewModel.title
    }
}
