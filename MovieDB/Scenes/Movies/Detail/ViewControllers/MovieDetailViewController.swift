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

class MovieDetailViewController: UIViewController {

    private let disposeBag = DisposeBag()
    internal var viewModel: MovieDetailViewModel!

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func bindViewModel() {
        assert(viewModel != nil)

        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        let input = MovieDetailViewModel
            .Input(trigger: Driver.merge(viewWillAppear),
         backButtonTrigger: backButton.rx.tap.asDriver())

        let output = viewModel.transform(input: input)

        [output.movieDetail.drive(movieDetailBinding),
        output.error.drive(errorBinding)]
            .forEach {
                $0.disposed(by: disposeBag)
        }

        output.dismiss.drive()
            .disposed(by: disposeBag)
    }

    var movieDetailBinding: Binder<MovieDetailItemViewModel> {
        return Binder(self, binding: { (vc, viewModel) in
            vc.titleLabel.text = viewModel.movieDetail.title
            vc.voteLabel.text = viewModel.movieDetail.voteAverage?.description
            vc.backdropImage.kf.setImage(with: viewModel.movieDetail.backdropPath?.createFullImageURL())
            vc.posterImage.kf.setImage(with: viewModel.movieDetail.posterPath?.createFullImageURL())
            vc.overviewLabel.text = viewModel.movieDetail.overview
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
