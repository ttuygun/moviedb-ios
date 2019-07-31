//
//  MovieDetailViewController.swift
//  MovieDB
//
//  Created by Tarık Taha Uygun on 28.07.2019.
//  Copyright © 2019 Tarık Taha Uygun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Domain
import RxKingfisher

class DetailViewController: UIViewController {

    private let disposeBag = DisposeBag()
    internal var viewModelMovie: MovieDetailViewModel!
    internal var viewModelTVShow: TVShowDetailViewModel!

    @IBOutlet weak var creditsCollectionView: UICollectionView!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: SwiftShadowImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCollectionViewCells()
        bindViewModelMovie()
        bindViewModelTVShow()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func registerCollectionViewCells() {
        creditsCollectionView
            .register(UINib(nibName: CreditsItemCollectionViewCell.reuseID, bundle: nil),
         forCellWithReuseIdentifier: CreditsItemCollectionViewCell.reuseID)
    }

    private func bindViewModelMovie() {
        guard let viewModelMovie = viewModelMovie else {
            return
        }
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        let input = MovieDetailViewModel
            .Input(trigger: Driver.merge(viewWillAppear),
                   backButtonTrigger: backButton.rx.tap.asDriver(),
                   shareButtonTrigger: shareButton.rx.tap.asDriver())

        let output = viewModelMovie.transform(input: input)

        [output.movieDetail.drive(movieDetailBinding),
         output.error.drive(errorBinding)]
            .forEach {
                $0.disposed(by: disposeBag)
        }

        output.credits.drive(
            creditsCollectionView
                .rx.items(cellIdentifier: CreditsItemCollectionViewCell.reuseID,
                          cellType: CreditsItemCollectionViewCell.self)) {_, viewModel, cell in
                            cell.bind(viewModel)
            }.disposed(by: disposeBag)

        output.dismiss.drive()
            .disposed(by: disposeBag)

        output.shareAction.drive()
            .disposed(by: disposeBag)

        output.credits.drive()
            .disposed(by: disposeBag)

    }

    private func bindViewModelTVShow() {
        guard let viewModelTVShow = viewModelTVShow else {
            return
        }
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        let input = TVShowDetailViewModel
            .Input(trigger: Driver.merge(viewWillAppear),
                   backButtonTrigger: backButton.rx.tap.asDriver(),
                   shareButtonTrigger: shareButton.rx.tap.asDriver())

        let output = viewModelTVShow.transform(input: input)

        [output.tvShowDetail.drive(tvShowDetailBinding),
         output.error.drive(errorBinding)]
            .forEach {
                $0.disposed(by: disposeBag)
        }

        output.credits.drive(
            creditsCollectionView
                .rx.items(cellIdentifier: CreditsItemCollectionViewCell.reuseID,
                          cellType: CreditsItemCollectionViewCell.self)) {_, viewModel, cell in
                            cell.bind(viewModel)
            }.disposed(by: disposeBag)

        output.dismiss.drive()
            .disposed(by: disposeBag)

        output.shareAction.drive()
            .disposed(by: disposeBag)

        output.credits.drive()
            .disposed(by: disposeBag)

    }

    var movieDetailBinding: Binder<MovieDetailItemViewModel> {
        return Binder(self, binding: { (vc, viewModel) in
            vc.titleLabel.text = viewModel.movieDetail.title?.uppercased()
            vc.voteLabel.text = viewModel.movieDetail.voteAverage?.description
            vc.backdropImage.kf.setImage(with: viewModel.movieDetail.backdropPath?.createFullImageURL(), placeholder: UIImage(named: "backdropImage"))
            vc.posterImage.imageView.kf.setImage(with: viewModel.movieDetail.posterPath?.createFullImageURL(), placeholder: UIImage(named: "posterImage"))
            vc.overviewLabel.text = viewModel.movieDetail.overview
            vc.genresLabel.text = viewModel.genres
            vc.popularityLabel.text = viewModel.popularity
        })
    }

    var tvShowDetailBinding: Binder<TVShowDetailItemViewModel> {
        return Binder(self, binding: { (vc, viewModel) in
            vc.titleLabel.text = viewModel.tvShowDetail.name?.uppercased()
            vc.voteLabel.text = viewModel.tvShowDetail.voteAverage?.description
            vc.backdropImage.kf.setImage(with: viewModel.tvShowDetail.backdropPath?.createFullImageURL(), placeholder: UIImage(named: "backdropImage"))
            vc.posterImage.imageView.kf.setImage(with: viewModel.tvShowDetail.posterPath?.createFullImageURL(), placeholder: UIImage(named: "posterImage"))
            vc.overviewLabel.text = viewModel.tvShowDetail.overview
            vc.genresLabel.text = viewModel.genres
            vc.popularityLabel.text = viewModel.popularity
        })
    }

    var errorBinding: Binder<Error> {
        return Binder(self, binding: { vc, _ in
            let alert = UIAlertController(title: "Save Error",
                                          message: "Something went wrong",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss",
                                       style: UIAlertAction.Style.cancel,
                                       handler: nil)
            alert.addAction(action)
            vc.present(alert, animated: true, completion: nil)
        })
    }
}
