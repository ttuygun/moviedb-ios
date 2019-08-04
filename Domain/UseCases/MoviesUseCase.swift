//
//  MoviesUseCase.swift
//  Domain
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import RxSwift

public protocol MoviesUseCase {
    func topRated() -> Observable<[Movie]>
    func nowPlaying() -> Observable<[Movie]>
    func popular() -> Observable<[Movie]>
    func detail(id: Int) -> Observable<MovieDetail>
    func credits(id: Int) -> Observable<Credit>
    func videos(id: Int) -> Observable<[Video]>
}
