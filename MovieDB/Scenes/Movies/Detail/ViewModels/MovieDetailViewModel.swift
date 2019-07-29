//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Domain

final class MovieDetailViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
        let backButtonTrigger: Driver<Void>
    }

    struct Output {
        let fetching: Driver<Bool>
        let movieDetail: Driver<MovieDetailItemViewModel>
        let dismiss: Driver<Void>
        let error: Driver<Error>
    }

    private let movie: Movie
    private let useCase: MoviesUseCase
    private let navigator: DefaultMovieDetailNavigator

    init(useCase: MoviesUseCase, navigator: DefaultMovieDetailNavigator, movie: Movie) {
        self.useCase = useCase
        self.navigator = navigator
        self.movie = movie
    }

    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()

        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()

        let movieDetail = input.trigger.flatMapLatest {
            self.useCase.detail(id: self.movie.id ?? 0)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
                .map {
                    MovieDetailItemViewModel(with: $0)
            }
        }

        let dismiss = Driver.of(input.backButtonTrigger)
                .merge()
                .do(onNext: navigator.toMovies)

        return Output(fetching: fetching,
                      movieDetail: movieDetail,
                      dismiss: dismiss,
                      error: errors)
    }
}
