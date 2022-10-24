//
//  FavoriteStorage.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation
import RxSwift

protocol FavoriteStorage {
    func fetchFavorites() -> Single<[String]>

    func isFavorite(of identifier: String) -> Single<Bool>

    func setFavorite(for identifier: String, createdAt date: Date) -> Completable

    func setUnfavorite(for identifier: String) -> Completable
}
