//
//  TVShowDetailItemViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 30.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain

final class TVShowDetailItemViewModel {
    let title: String
    let overview: String
    let homePage: String
    let tvShowDetail: TVShowDetail
    var genres: String = ""
    var popularity: String = ""
    let vote: String
    var backdropURL: URL?
    var posterURL: URL?

    init(with tvShowDetail: TVShowDetail) {
        self.tvShowDetail = tvShowDetail
        if let genres = tvShowDetail.genres {
            let genresString = genres.map {
                "\($0.name ?? "")"
            }
            self.genres = genresString.joined(separator: " , ")
        }
        if let popularity = tvShowDetail.popularity {
            self.popularity = "\(popularity) People watching"
        }
        self.title = tvShowDetail.name?.uppercased() ?? ""
        self.overview = tvShowDetail.overview ?? ""
        self.homePage = tvShowDetail.homepage ?? ""
        self.vote = tvShowDetail.voteAverage?.description ?? ""
        if let backdropURL = tvShowDetail.backdropPath {
            let imageURLBuilder = ImageURLBuilder(imageURLType: .original, path: backdropURL)
            self.backdropURL = imageURLBuilder.url
        }
        if let posterPath = tvShowDetail.posterPath {
            let imageURLBuilder = ImageURLBuilder(imageURLType: .original, path: posterPath)
            self.posterURL = imageURLBuilder.url
        }
    }
}
