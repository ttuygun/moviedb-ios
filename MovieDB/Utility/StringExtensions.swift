//
//  StringExtensions.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation

extension String {

    func transformPosterURL() -> String {
        return "https://image.tmdb.org/t/p/original\(self)"
    }
}
