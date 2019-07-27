//
//  TVShowUseCase.swift
//  NetworkPlatform
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class TVShowUseCase: Domain.TVShowsUseCase {
    private let network: TVShowNetwork

    init(network: TVShowNetwork) {
        self.network = network
    }

    func topRated() -> Observable<[TVShow]> {
        return network.topRated()
    }

    func popular() -> Observable<[TVShow]> {
        return network.popular()
    }

    func detail(id: String) -> Observable<TVShowDetail> {
        return network.detail(id: id)
    }

    func credits(id: String) -> Observable<Credits> {
        return network.credits(id: id)
    }
}

