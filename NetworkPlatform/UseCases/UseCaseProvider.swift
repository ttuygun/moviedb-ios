//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {

    private let networkProvider: NetworkProvider

    public init() {
        networkProvider = NetworkProvider()
    }

    public func makeMoviesUseCase() -> Domain.MoviesUseCase {
        return MoviesUseCase(network: networkProvider.makeMovieNetwork())
    }

    public func makeTVShowsUseCase() -> Domain.TVShowsUseCase {
        return TVShowUseCase(network: networkProvider.makeTVShowNetwork())
    }
}

