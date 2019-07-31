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
        let shareButtonTrigger: Driver<Void>
    }

    struct Output {
        let fetching: Driver<Bool>
        let movieDetail: Driver<MovieDetailItemViewModel>
        let credits: Driver<[CreditsItemViewModel]>
        let dismiss: Driver<Void>
        let shareAction: Driver<MovieDetailItemViewModel>
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
            self.useCase.detail(id: self.movie.id)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
                .map {
                    MovieDetailItemViewModel(with: $0)
                }
        }

        let credits = input.trigger.flatMapLatest {
            self.useCase.credits(id: self.movie.id)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
                .map {
                    $0.cast.map {
                        CreditsItemViewModel(with: $0)
                    }
                }
            
        }

        let dismiss = Driver.of(input.backButtonTrigger)
                .merge()
                .do(onNext: navigator.toMovies)

        let shareAction = Driver.of(input.shareButtonTrigger)
            .merge()
            .withLatestFrom(movieDetail)
            .do(onNext: navigator.shareMovieAction)

        return Output(fetching: fetching,
                      movieDetail: movieDetail,
                      credits: credits,
                      dismiss: dismiss,
                      shareAction: shareAction,
                      error: errors)
    }
}
