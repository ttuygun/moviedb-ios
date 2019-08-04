//
//  CreditsItemViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 29.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain

final class CreditsItemViewModel {
    let name: String?
    let job: String?
    var profileURL: URL?

    init(with castCrew: CastCrew?) {
        self.name = castCrew?.name
        self.job = castCrew?.job
        if let profilePath = castCrew?.profilePath {
            let imageURLBuilder = ImageURLBuilder(imageURLType: .original, path: profilePath)
            self.profileURL = imageURLBuilder.url
        }
    }
}
