//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    func makeMoviesUseCase() -> MoviesUseCase
    func makeTVShowsUseCase() -> TVShowsUseCase
//    func makeProfileUseCase() -> ProfileUseCase
}

