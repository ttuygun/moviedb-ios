//
//  TVShowDetailNavigator.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 30.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import XCDYouTubeKit

protocol TVShowDetailNavigator {
    func toTVShows()
    func shareTVShowAction(_ tvShowDetail: TVShowDetailItemViewModel)
    func playVideoAction(_ video: VideoItemViewModel)
}

final class DefaultTVShowDetailNavigator: TVShowDetailNavigator {
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toTVShows() {
        navigationController.popViewController(animated: true)
    }

    func shareTVShowAction(_ tvShowDetail: TVShowDetailItemViewModel) {
        let vc = UIActivityViewController(activityItems: [tvShowDetail.title,
                                                          tvShowDetail.homePage],
                                          applicationActivities: nil)
        navigationController.present(vc, animated: true)
    }

    func playVideoAction(_ video: VideoItemViewModel) {
        let playerViewController = AVPlayerViewController()
        navigationController.present(playerViewController, animated: true, completion: nil)
    }

}
