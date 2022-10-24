//
//  DefaultFavoriteGIFRepository.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

class DefaultFavoriteGIFRepository: FavoriteGIFRepository {
    let favoriteStorage: FavoriteStorage

    init(favoriteStorage: FavoriteStorage) {
        self.favoriteStorage = favoriteStorage
    }

    func fetchFavorites() -> Single<[String]> {
        return self.favoriteStorage.fetchFavorites()
    }

    func isFavorite(of identifier: String) -> Single<Bool> {
        return self.favoriteStorage.isFavorite(of: identifier)
    }

    func setFavorite(for identifier: String, createdAt date: Date) -> Completable {
        return self.favoriteStorage.setFavorite(for: identifier, createdAt: date)
    }

    func setUnfavorite(for identifier: String) -> Completable {
        return self.favoriteStorage.setUnfavorite(for: identifier)
    }
}
