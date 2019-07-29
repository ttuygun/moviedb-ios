//
//  MovieNetwork.swift
//  NetworkPlatform
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxMoya
import Moya

protocol MovieNetworkProtocol {
    func topRated() -> Observable<[Movie]>
    func nowPlaying() -> Observable<[Movie]>
    func popular() -> Observable<[Movie]>
    func detail(id: Int) -> Observable<MovieDetail>
    func credits(id: Int) -> Observable<Credits>
}

public final class MovieNetwork: MovieNetworkProtocol {

    let provider: MoyaProvider<MDApi>

    public init() {
        self.provider = MoyaProvider<MDApi>()
    }

    public func topRated() -> Observable<[Movie]> {
        return provider.rx.request(.movieTopRated)
            .filterSuccessfulStatusCodes()
            .debug()
            .map([Movie].self, atKeyPath: "results")
            .asObservable()
    }

    public func nowPlaying() -> Observable<[Movie]> {
        return provider.rx.request(.movieNowPlaying)
            .filterSuccessfulStatusCodes()
            .debug()
            .map([Movie].self, atKeyPath: "results")
            .asObservable()
    }

    public func popular() -> Observable<[Movie]> {
        return provider.rx.request(.moviePopular)
            .filterSuccessfulStatusCodes()
            .debug()
            .map([Movie].self, atKeyPath: "results")
            .asObservable()
    }

    public func detail(id: Int) -> Observable<MovieDetail> {
        return provider.rx.request(.movieDetail(id: id))
            .filterSuccessfulStatusCodes()
            .debug()
            .map(MovieDetail.self)
            .asObservable()
    }

    public func credits(id: Int) -> Observable<Credits> {
        return provider.rx.request(.movieCredits(id: id))
            .filterSuccessfulStatusCodes()
            .debug()
            .map(Credits.self)
            .asObservable()
    }
}
