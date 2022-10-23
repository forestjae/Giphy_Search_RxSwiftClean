//
//  FavoriteGIFRepository.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

protocol FavoriteGIFRepository {
    func fetchFavorites() -> Single<[String]>

    func isFavorite(of identifier: String) -> Observable<Bool>

    func setFavorite(for identifier: String) -> Completable

    func setUnfavorite(for identifier: String) -> Completable
}
