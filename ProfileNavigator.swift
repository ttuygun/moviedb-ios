//
//  ProfileNavigator.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 31.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol ProfileNavigator {
    func toProfile()
}

class DefaultProfileNavigator: ProfileNavigator {

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
    
    func toProfile() {
        let vc = storyboard.instantiateViewController(ofType: ProfileViewController.self)
        navigationController.pushViewController(vc, animated: true)
    }

}
