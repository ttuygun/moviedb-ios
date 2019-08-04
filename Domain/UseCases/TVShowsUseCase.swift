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
    func detail(id: Int) -> Observable<TVShowDetail>
    func credits(id: Int) -> Observable<Credit>
    func videos(id: Int) -> Observable<[Video]>
}
