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

    init(with tvShowDetail: TVShowDetail) {
        self.tvShowDetail = tvShowDetail
    }
}
