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
        topRatedMoviesCollectionView.register(UINib(nibName: MovieItemCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: MovieItemCollectionViewCell.reuseID)
        nowPlayingMoviesCollectionView.register(UINib(nibName: MovieItemCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: MovieItemCollectionViewCell.reuseID)
        popularMoviesCollectionView.register(UINib(nibName: MovieItemCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: MovieItemCollectionViewCell.reuseID)
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

        output.nowPlayingMovies.drive(
            nowPlayingMoviesCollectionView
            .rx.items(cellIdentifier: MovieItemCollectionViewCell.reuseID,
                            cellType: MovieItemCollectionViewCell.self)) {_, viewModel, cell in
                                cell.bind(viewModel)
        }.disposed(by: disposeBag)

        output.topRatedMovies.drive(
            topRatedMoviesCollectionView
                .rx.items(cellIdentifier: MovieItemCollectionViewCell.reuseID,
                          cellType: MovieItemCollectionViewCell.self)) {_, viewModel, cell in
                            cell.bind(viewModel)
            }.disposed(by: disposeBag)

        output.popularMovies.drive(
            popularMoviesCollectionView
                .rx.items(cellIdentifier: MovieItemCollectionViewCell.reuseID,
                          cellType: MovieItemCollectionViewCell.self)) {_, viewModel, cell in
                            cell.bind(viewModel)
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
