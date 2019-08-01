//
//  VideoItemViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 1.08.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain

final class VideoItemViewModel {
    var key: String = ""
    let videos: [Video]?

    init(with videos: [Video]?) {
        self.videos = videos
        if let videos = videos {
            key = videos.first?.key ?? ""
        }
    }
}

