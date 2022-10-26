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

    func isFavorite(of identifier: String) -> Single<Bool>

    func setFavorite(for identifier: String, createdAt date: Date) -> Single<Bool>

    func setUnfavorite(for identifier: String) -> Single<Bool>
}
