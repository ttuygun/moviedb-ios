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
    var posterURL: URL?
    var backdropURL: URL?
    let vote: String

    init(with movie: Movie) {
        self.movie = movie
        title = movie.title?.uppercased()
        releaseDate = movie.releaseDate
        if let posterPath = movie.posterPath {
            let imageURLBuilder = ImageURLBuilder(imageURLType: .original, path: posterPath)
            self.posterURL = imageURLBuilder.url
        }
        if let backdropURL = movie.backdropPath {
            let imageURLBuilder = ImageURLBuilder(imageURLType: .original, path: backdropURL)
            self.backdropURL = imageURLBuilder.url
        }
        vote = movie.voteAverage?.description.description ?? ""
    }
}
