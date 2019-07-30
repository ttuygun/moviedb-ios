//
//  TVShowsViewModel.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 30.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import Domain

final class TVShowsViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Void>
        let selectionTopRated: Driver<IndexPath>
        let selectionPopular: Driver<IndexPath>
    }

    struct Output {
        let fetching: Driver<Bool>

        let topRatedTVShows: Driver<[TVShowItemViewModel]>
        let popularTVShows: Driver<[TVShowItemViewModel]>

        let selectedTopRated: Driver<TVShow>
        let selectedPopular: Driver<TVShow>

        let error: Driver<Error>
    }

    private let useCase: TVShowsUseCase
    private let navigator: TVShowsNavigator

    init(useCase: TVShowsUseCase, navigator: TVShowsNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()

        let topRatedTVShows = input.trigger.flatMapLatest {
            self.useCase.topRated()
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
                .map { $0.map { TVShowItemViewModel(with: $0) } }
        }

        let popularTVShows = input.trigger.flatMapLatest {
            self.useCase.popular()
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
                .map { $0.map { TVShowItemViewModel(with: $0) } }
        }

        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()

        let selectedTopRated = input.selectionTopRated
            .withLatestFrom(topRatedTVShows) { (indexPath, tvShows) -> TVShow in
                tvShows[indexPath.row].tvShow
            }.do(onNext: navigator.toTVShowDetail)

        let selectedPopular = input.selectionPopular
            .withLatestFrom(popularTVShows) { (indexPath, tvShows) -> TVShow in
                tvShows[indexPath.row].tvShow
            }.do(onNext: navigator.toTVShowDetail)

        return Output(fetching: fetching,
                      topRatedTVShows: topRatedTVShows,
                      popularTVShows: popularTVShows,
                      selectedTopRated: selectedTopRated,
                      selectedPopular: selectedPopular,
                      error: errors)
    }
}
