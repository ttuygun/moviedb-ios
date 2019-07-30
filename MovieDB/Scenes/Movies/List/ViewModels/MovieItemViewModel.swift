//
//  MovieItemViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class MovieItemViewModel {
    let movie: Movie
    let title: String?
    let releaseDate: String?
    var posterPathURL: URL?
    var backdropPathURL: URL?

    init(with movie: Movie) {
        self.movie = movie
        title = movie.title?.uppercased()
        releaseDate = movie.releaseDate
        if let posterPath = movie.posterPath, let url = URL(string: posterPath.transformPosterURL()) {
            posterPathURL = url
        }
        if let backdropPath = movie.backdropPath, let url = URL(string: backdropPath.transformPosterURL()) {
            backdropPathURL = url
        }
    }
}
