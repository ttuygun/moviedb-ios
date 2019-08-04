//
//  ImageURLBuilder.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 4.08.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation


enum ImageURLType: String {
    case original = "original"
    case w500 = "w500"
}

struct ImageURLBuilder {
    let baseURL: String = "https://image.tmdb.org/t/p/"
    let imageURLType: ImageURLType
    let path: String

    init(imageURLType: ImageURLType, path: String) {
        self.imageURLType = imageURLType
        self.path = path
    }

    var url: URL {
        return URL(string: baseURL + imageURLType.rawValue + path)!
    }
}
