//
//  MovieDetailItemViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain

final class MovieDetailItemViewModel {
    let movieDetail: MovieDetail

    init(with movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
}


