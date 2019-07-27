//
//  TVShow.swift
//  Domain
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation

public struct TVShow: Decodable {
    let originalName: String
    let genreIDS: [Int]
    let name: String
    let popularity: Double
    let originCountry: [OriginCountry]
    let voteCount: Int
    let firstAirDate, backdropPath: String
    let originalLanguage: OriginalLanguage
    let id: Int
    let voteAverage: Double
    let overview, posterPath: String

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}

enum OriginCountry: String, Decodable {
    case es = "ES"
    case gb = "GB"
    case jp = "JP"
    case us = "US"
}
