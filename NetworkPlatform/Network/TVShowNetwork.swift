//
//  TVShowNetwork.swift
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

protocol TVShowNetworkProtocol {
    func topRated() -> Observable<[TVShow]>
    func popular() -> Observable<[TVShow]>
    func detail(id: Int) -> Observable<TVShowDetail>
    func credits(id: Int) -> Observable<Credits>
    func videos(id: Int) -> Observable<[Video]>
}

public final class TVShowNetwork: TVShowNetworkProtocol {

    let provider: MoyaProvider<MDApi>

    public init() {
        self.provider = MoyaProvider<MDApi>()
    }

    public func topRated() -> Observable<[TVShow]> {
        return provider.rx.request(.tvShowTopRated)
            .filterSuccessfulStatusCodes()
            .debug()
            .map([TVShow].self, atKeyPath: "results")
            .asObservable()
    }

    public func popular() -> Observable<[TVShow]> {
        return provider.rx.request(.tvShowPopular)
            .filterSuccessfulStatusCodes()
            .debug()
            .map([TVShow].self, atKeyPath: "results")
            .asObservable()
    }

    public func detail(id: Int) -> Observable<TVShowDetail> {
        return provider.rx.request(.tvShowDetail(id: id))
            .filterSuccessfulStatusCodes()
            .debug()
            .map(TVShowDetail.self)
            .asObservable()
    }

    public func credits(id: Int) -> Observable<Credits> {
        return provider.rx.request(.tvShowCredits(id: id))
            .filterSuccessfulStatusCodes()
            .debug()
            .map(Credits.self)
            .asObservable()
    }

    public func videos(id: Int) -> Observable<[Video]> {
        return provider.rx.request(.tvShowVideos(id: id))
            .filterSuccessfulStatusCodes()
            .debug()
            .map([Video].self, atKeyPath: "results")
            .asObservable()
    }
}
