//
//  TVShowsNavigator.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 30.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol TVShowsNavigator {
    func toTVShows()
    func toTVShowDetail(_ tvShow: TVShow)
}

class DefaultTVShowsNavigator: TVShowsNavigator {
    private let storyboard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider

    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyboard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyboard = storyboard
    }

    func toTVShows() {
        let vc = storyboard.instantiateViewController(ofType: TVShowsViewController.self)
        vc.viewModel = TVShowsViewModel(useCase: services.makeTVShowsUseCase(), navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func toTVShowDetail(_ tvShow: TVShow) {
        let navigator = DefaultTVShowDetailNavigator(navigationController: navigationController)
        let viewModel = TVShowDetailViewModel(useCase: services.makeTVShowsUseCase(), navigator: navigator, tvShow: tvShow)
        let vc = storyboard.instantiateViewController(ofType: DetailViewController.self)
        vc.viewModelTVShow = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
