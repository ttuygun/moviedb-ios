//
//  PopularTVShowsTableViewCell.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 30.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import UIKit
import Kingfisher

class PopularTVShowsTableViewCell: UITableViewCell {

    @IBOutlet weak var backdropImage: SwiftShadowImageView!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bind(_ viewModel: TVShowItemViewModel) {
        backdropImage.imageView.kf.setImage(with: viewModel.backdropPathURL)
        voteLabel.text = viewModel.voteAverage
        titleLabel.text = viewModel.title?.uppercased()
    }

}
