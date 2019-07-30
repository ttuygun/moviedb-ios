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
    let profilePath: String?

    init(with castCrew: CastCrew?) {
        self.name = castCrew?.name
        self.job = castCrew?.job
        self.profilePath = castCrew?.profilePath
    }
}
