//
//  DetailViewModel.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/25.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    weak var coordinator: DetailCoordinator?

    struct Input {
        let viewWillAppear: Observable<Void>
        let favoriteButtonDidTap: Observable<Void>
    }

    struct Output {
        let isFavorite: Driver<Bool>
    }

    // MARK: - Output
    let animatedImageURL: String
    let title: String
    let userImageURL: String?
    let userDisplayedName: String?
    let userName: String?
    let source: String?
    let isVerified: Bool?
    let aspectRatio: Double

    private let favoriteGIFUseCase: FavoriteGIFUseCase
    private let identifier: String

    init(image: GIF, favoriteGIFUseCase: FavoriteGIFUseCase) {
        self.animatedImageURL = image.gifBundle.originalMp4Image
        self.title = image.type.description
        self.userDisplayedName = image.user?.displayedName ?? image.user?.name
        self.userName = image.user?.name
        self.source = image.source
        self.isVerified = image.user?.isVerified
        self.identifier = image.identifier
        self.userImageURL = image.user?.avatarImageURL
        self.aspectRatio = image.gifBundle.originalHeight / image.gifBundle.originalWidth
        self.favoriteGIFUseCase = favoriteGIFUseCase
    }

    func transform(input: Input) -> Output {
        let favoriteButtonDidTap = input.favoriteButtonDidTap.share()
        let viewWillAppear = input.viewWillAppear

        let isFavoriteTrigger = Observable.merge(viewWillAppear, favoriteButtonDidTap)
            .flatMap {
                self.favoriteGIFUseCase.isFavorite(of: self.identifier)
            }
            .share()

        let setUnfavorite = favoriteButtonDidTap.withLatestFrom(isFavoriteTrigger)
            .filter { $0 }
            .flatMap { _ in
                self.favoriteGIFUseCase.setUnfavorite(for: self.identifier)
            }

        let setFavorite = favoriteButtonDidTap.withLatestFrom(isFavoriteTrigger)
            .filter { !$0 }
            .flatMap { _ in
                self.favoriteGIFUseCase.setFavorite(for: self.identifier)
            }

        let isFavorite = Observable.merge(isFavoriteTrigger, setUnfavorite, setFavorite)
            .asDriver(onErrorJustReturn: false)

        return Output(isFavorite: isFavorite)
    }
}
