//
//  MovieItemViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain

final class MovieItemViewModel {
    let title: String?
    let releaseDate: String?
    let movie: Movie

    init(with movie: Movie) {
        self.movie = movie
        title = movie.title?.uppercased()
        releaseDate = movie.releaseDate
    }
}
