//
//  MoviesViewController.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//


import Domain
import RxCocoa
import RxSwift
import UIKit

class MoviesViewController: UIViewController {

    private let disposeBag = DisposeBag()
    internal var viewModel: MoviesViewModel!

    @IBOutlet weak private var topRatedMoviesCollectionView: UICollectionView!
    @IBOutlet weak private var nowPlayingMoviesCollectionView: UICollectionView!
    @IBOutlet weak private var popularMoviesCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionViewCells()
        bindViewModel()
    }

    private func registerCollectionViewCells() {
        topRatedMoviesCollectionView.register(UINib(nibName: MovieBackDropItemCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: MovieBackDropItemCollectionViewCell.reuseID)
        nowPlayingMoviesCollectionView.register(UINib(nibName: PosterItemCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: PosterItemCollectionViewCell.reuseID)
        popularMoviesCollectionView.register(UINib(nibName: PosterItemCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: PosterItemCollectionViewCell.reuseID)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.navigationController?.navigationBar.isHidden = false
    }

    private func bindViewModel() {
        assert(viewModel != nil)

        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        let input = MoviesViewModel
            .Input(trigger: Driver.merge(viewWillAppear),
                   selectionTopRated: topRatedMoviesCollectionView.rx.itemSelected.asDriver(),
                   selectionNowPlaying: nowPlayingMoviesCollectionView.rx.itemSelected.asDriver(),
                   selectionPopular: popularMoviesCollectionView.rx.itemSelected.asDriver())

        let output = viewModel.transform(input: input)

        output.topRatedMovies.drive(
            topRatedMoviesCollectionView
                .rx.items(cellIdentifier: MovieBackDropItemCollectionViewCell.reuseID,
                          cellType: MovieBackDropItemCollectionViewCell.self)) {_, viewModel, cell in
                            cell.bind(viewModel)
            }.disposed(by: disposeBag)

        output.nowPlayingMovies.drive(
            nowPlayingMoviesCollectionView
                .rx.items(cellIdentifier: PosterItemCollectionViewCell.reuseID,
                          cellType: PosterItemCollectionViewCell.self)) {_, viewModel, cell in
                            cell.bindMovie(viewModel, showVote: false)
            }.disposed(by: disposeBag)

        output.popularMovies.drive(
            popularMoviesCollectionView
                .rx.items(cellIdentifier: PosterItemCollectionViewCell.reuseID,
                          cellType: PosterItemCollectionViewCell.self)) {_, viewModel, cell in
                            cell.bindMovie(viewModel, showVote: true)
            }.disposed(by: disposeBag)

        output.selectedTopRated
            .drive()
            .disposed(by: disposeBag)
        output.selectedNowPlaying
            .drive()
            .disposed(by: disposeBag)
        output.selectedPopular
            .drive()
            .disposed(by: disposeBag)

    }
}
