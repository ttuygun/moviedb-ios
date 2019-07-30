//
//  TVShowsViewController.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 30.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import Domain
import RxCocoa
import RxSwift
import UIKit

class TVShowsViewController: UIViewController {

    private let disposeBag = DisposeBag()
    internal var viewModel: TVShowsViewModel!

    @IBOutlet weak private var topRatedTVShowsCollectionView: UICollectionView!
    @IBOutlet weak private var popularTVShowsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionViewCells()
        bindViewModel()
    }

    private func registerCollectionViewCells() {
        topRatedTVShowsCollectionView.register(UINib(nibName: MovieItemCollectionViewCell.reuseID, bundle: nil), forCellWithReuseIdentifier: MovieItemCollectionViewCell.reuseID)
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

        let input = TVShowsViewModel
            .Input(trigger: Driver.merge(viewWillAppear),
                   selectionTopRated: topRatedTVShowsCollectionView.rx.itemSelected.asDriver(),
                   selectionPopular: popularTVShowsTableView.rx.itemSelected.asDriver())

        let output = viewModel.transform(input: input)

        output.topRatedTVShows.drive(
            topRatedTVShowsCollectionView
                .rx.items(cellIdentifier: MovieItemCollectionViewCell.reuseID,
                          cellType: MovieItemCollectionViewCell.self)) {_, viewModel, cell in
                            cell.bindTVShow(viewModel)
            }.disposed(by: disposeBag)

        output.popularTVShows.drive(popularTVShowsTableView.rx.items(cellIdentifier: PopularTVShowsTableViewCell.reuseID, cellType: PopularTVShowsTableViewCell.self)) { _, viewModel, cell in
            cell.bind(viewModel)
            }.disposed(by: disposeBag)

        output.selectedTopRated
            .drive()
            .disposed(by: disposeBag)

        output.selectedPopular
            .drive()
            .disposed(by: disposeBag)

    }

}
