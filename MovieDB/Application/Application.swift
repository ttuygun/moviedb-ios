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
        moviesNavigationController.tabBarItem = UITabBarItem(title: "MOVIES",
                                                         image: UIImage(named: "moviesIcon"),
                                                         selectedImage: UIImage(named: "moviesIconSelected"))

        let moviesNavigator = DefaultMoviesNavigator(services: networkUseCaseProvider,
                                                  navigationController: moviesNavigationController,
                                                  storyboard: storyboard)

        let tvShowsNavigationController = UINavigationController()
        tvShowsNavigationController.tabBarItem = UITabBarItem(title: "TV",
                                                             image: UIImage(named: "tvIcon"),
                                                             selectedImage: UIImage(named: "tvIconSelected"))

        let tvShowsNavigator = DefaultTVShowsNavigator(services: networkUseCaseProvider,
                                                       navigationController: tvShowsNavigationController,
                                                       storyboard: storyboard)

        let profileNavigationController = UINavigationController()
        profileNavigationController.tabBarItem = UITabBarItem(title: "PROFILE",
                                                             image: UIImage(named: "profileIcon"),
                                                             selectedImage: UIImage(named: "profileIconSelected"))

        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintAdjustmentMode = .normal
        tabBarController.tabBar.tintColor = UIColor(hue:0.98, saturation:0.89, brightness:0.84, alpha:1.00)

        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().isTranslucent = true

        let profileNavigator = DefaultProfileNavigator(services: networkUseCaseProvider,
                                                       navigationController: profileNavigationController,
                                                       storyboard: storyboard)

        tabBarController.viewControllers = [
            moviesNavigationController,
            tvShowsNavigationController,
            profileNavigationController
        ]
        window.rootViewController = tabBarController

        moviesNavigator.toMovies()
        tvShowsNavigator.toTVShows()
        profileNavigator.toProfile()
    }
}
