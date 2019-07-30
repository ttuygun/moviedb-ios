//
//  TVShowItemViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 30.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class TVShowItemViewModel {
    let tvShow: TVShow
    let title: String?
    var posterPathURL: URL?
    var backdropPathURL: URL?
    var voteAverage: String?

    init(with tvShow: TVShow) {
        self.tvShow = tvShow
        title = tvShow.name?.uppercased()
        if let posterPath = tvShow.posterPath, let url = URL(string: posterPath.transformPosterURL()) {
            posterPathURL = url
        }
        if let backdropPath = tvShow.backdropPath, let url = URL(string: backdropPath.transformPosterURL()) {
            backdropPathURL = url
        }
        if let voteAverage = tvShow.voteAverage {
            self.voteAverage = String(describing: voteAverage)
        } else {
            self.voteAverage = ""
        }
    }
}
