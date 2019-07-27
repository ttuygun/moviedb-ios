//
//  Application.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform

final class Application {
    static let shared = Application()

    private let networkUseCaseProvider: Domain.UseCaseProvider

    private init() {
        networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)


    }
}
