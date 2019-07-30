//
//  MovieDetailNavigator.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailNavigator {
    func toMovies()
}

final class DefaultMovieDetailNavigator: MovieDetailNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toMovies() {
        navigationController.popViewController(animated: true)
    }

}
