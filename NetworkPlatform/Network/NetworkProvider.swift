//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Moya

protocol NetworkProviderProtocol {
    func makeMovieNetwork() -> MovieNetwork
    func makeTVShowNetwork() -> TVShowNetwork
}

public class NetworkProvider: NetworkProviderProtocol {

    public init() {}

    public func makeMovieNetwork() -> MovieNetwork {
        return MovieNetwork()
    }

    public func makeTVShowNetwork() -> TVShowNetwork {
        return TVShowNetwork()
    }
}
