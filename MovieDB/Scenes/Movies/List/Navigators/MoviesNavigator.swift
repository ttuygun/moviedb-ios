//
//  MoviesNavigator.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol MoviesNavigator {
    func toMovies()
    func toMovieDetail(_ movie: Movie)
}

class MoviesListNavigator: MoviesNavigator {
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

    func toMovies() {
        let vc = storyboard.instantiateViewController(ofType: MoviesViewController.self)
        vc.viewModel = MoviesViewModel(useCase: services.makeMoviesUseCase(), navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }

    func toMovieDetail(_ movie: Movie) {
        
    }
}
