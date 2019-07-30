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

        let moviesNavigationController = UINavigationController()
        moviesNavigationController.tabBarItem = UITabBarItem(title: "Movies",
                                                         image: UIImage(named: "iconMovies"),
                                                         selectedImage: UIImage(named: "iconMoviesSelected"))

        let moviesNavigator = DefaultMoviesNavigator(services: networkUseCaseProvider,
                                                  navigationController: moviesNavigationController,
                                                  storyboard: storyboard)

        let tvShowsNavigationController = UINavigationController()
        tvShowsNavigationController.tabBarItem = UITabBarItem(title: "TV",
                                                             image: UIImage(named: "iconTV"),
                                                             selectedImage: UIImage(named: "iconTVSelected"))

        let tvShowsNavigator = DefaultTVShowsNavigator(services: networkUseCaseProvider,
                                                       navigationController: tvShowsNavigationController,
                                                       storyboard: storyboard)

        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                             image: UIImage(named: "iconProfile"),
                                                             selectedImage: UIImage(named: "iconProfileSelected"))

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            moviesNavigationController,
            tvShowsNavigationController,
            profileNavigationController
        ]
        window.rootViewController = tabBarController

        moviesNavigator.toMovies()
        tvShowsNavigator.toTVShows()
    }
}
