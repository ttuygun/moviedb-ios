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
    let tvShowDetail: TVShowDetail
    var genres: String = ""
    var popularity: String = ""

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
    }
}
