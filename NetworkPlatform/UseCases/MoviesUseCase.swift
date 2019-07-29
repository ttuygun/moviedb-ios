//
//  MoviesUseCase.swift
//  NetworkPlatform
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class MoviesUseCase: Domain.MoviesUseCase {
    private let network: MovieNetwork

    init(network: MovieNetwork) {
        self.network = network
    }

    func topRated() -> Observable<[Movie]> {
        return network.topRated()
    }

    func nowPlaying() -> Observable<[Movie]> {
        return network.nowPlaying()
    }

    func popular() -> Observable<[Movie]> {
        return network.popular()
    }

    func detail(id: Int) -> Observable<MovieDetail> {
        return network.detail(id: id)
    }

    func credits(id: String) -> Observable<Credits> {
        return network.credits(id: id)
    }
}

