//
//  FavoriteGIFUseCase.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

protocol FavoriteGIFUseCase {
    func fetchFavorites() -> Single<[String]>

    func isFavorite(of identifier: String) -> Single<Bool>

    func setFavorite(for identifier: String) -> Single<Bool>

    func setUnfavorite(for identifier: String) -> Single<Bool>
}

class DefaultFavoriteGIFUseCase: FavoriteGIFUseCase {
    let favoriteGIFRepository: FavoriteGIFRepository

    init(favoriteGIFRepository: FavoriteGIFRepository) {
        self.favoriteGIFRepository = favoriteGIFRepository
    }

    func fetchFavorites() -> Single<[String]> {
        self.favoriteGIFRepository.fetchFavorites()
    }

    func isFavorite(of identifier: String) -> Single<Bool> {
        self.favoriteGIFRepository.isFavorite(of: identifier)
    }

    func setFavorite(for identifier: String) -> Single<Bool> {
        self.favoriteGIFRepository.setFavorite(for: identifier, createdAt: Date())
    }

    func setUnfavorite(for identifier: String) -> Single<Bool> {
        self.favoriteGIFRepository.setUnfavorite(for: identifier)
    }
}
