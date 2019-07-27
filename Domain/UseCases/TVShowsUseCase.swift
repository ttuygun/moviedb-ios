//
//  TVShowsUseCase.swift
//  Domain
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import RxSwift

public protocol TVShowsUseCase {
    func topRated() -> Observable<[TVShow]>
    func popular() -> Observable<[TVShow]>
    func detail(id: String) -> Observable<TVShowDetail>
    func credits(id: String) -> Observable<Credits>
}
