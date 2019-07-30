//
//  MoviesViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 27.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Domain

final class MoviesViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
        let selectionTopRated: Driver<IndexPath>
        let selectionNowPlaying: Driver<IndexPath>
        let selectionPopular: Driver<IndexPath>
    }

    struct Output {
        let fetching: Driver<Bool>

        let topRatedMovies: Driver<[MovieItemViewModel]>
        let nowPlayingMovies: Driver<[MovieItemViewModel]>
        let popularMovies: Driver<[MovieItemViewModel]>

        let selectedTopRated: Driver<Movie>
        let selectedNowPlaying: Driver<Movie>
        let selectedPopular: Driver<Movie>

        let error: Driver<Error>
    }

    private let useCase: MoviesUseCase
    private let navigator: MoviesNavigator

    init(useCase: MoviesUseCase, navigator: MoviesNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()

        let topRatedMovies = input.trigger.flatMapLatest {
            self.useCase.topRated()
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
                .map { $0.map { MovieItemViewModel(with: $0) } }
        }

        let nowPlayingdMovies = input.trigger.flatMapLatest {
            self.useCase.nowPlaying()
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
                .map { $0.map { MovieItemViewModel(with: $0) } }
        }

        let popularMovies = input.trigger.flatMapLatest {
            self.useCase.popular()
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
                .map { $0.map { MovieItemViewModel(with: $0) } }
        }

        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()

        let selectedTopRated = input.selectionTopRated
            .withLatestFrom(topRatedMovies) { (indexPath, movies) -> Movie in
                movies[indexPath.row].movie
            }.do(onNext: navigator.toMovieDetail)

        let selectedNowPlaying = input.selectionNowPlaying
            .withLatestFrom(nowPlayingdMovies) { (indexPath, movies) -> Movie in
                movies[indexPath.row].movie
            }.do(onNext: navigator.toMovieDetail)

        let selectedPopular = input.selectionPopular
            .withLatestFrom(popularMovies) { (indexPath, movies) -> Movie in
                movies[indexPath.row].movie
            }.do(onNext: navigator.toMovieDetail)

        return Output(fetching: fetching,
                      topRatedMovies: topRatedMovies,
                      nowPlayingMovies: nowPlayingdMovies,
                      popularMovies: popularMovies,
                      selectedTopRated: selectedTopRated,
                      selectedNowPlaying: selectedNowPlaying,
                      selectedPopular: selectedPopular,
                      error: errors)
    }
}
