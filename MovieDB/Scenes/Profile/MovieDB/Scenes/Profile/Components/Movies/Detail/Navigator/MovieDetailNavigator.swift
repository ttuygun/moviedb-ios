//
//  MovieDetailNavigator.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import UIKit
import AVKit

protocol MovieDetailNavigator {
    func toMovies()
    func shareMovieAction(_ movie: MovieDetailItemViewModel)
    func playVideoAction(_ video: VideoItemViewModel)
}

final class DefaultMovieDetailNavigator: MovieDetailNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toMovies() {
        navigationController.popViewController(animated: true)
    }

    func shareMovieAction(_ movie: MovieDetailItemViewModel) {
        let vc = UIActivityViewController(activityItems: [movie.title,
                                                          movie.homepage],
                                          applicationActivities: nil)
        navigationController.present(vc, animated: true)
    }

    func playVideoAction(_ video: VideoItemViewModel) {
        let playerViewController = AVPlayerViewController()
        navigationController.present(playerViewController, animated: true, completion: nil)
    }
}
