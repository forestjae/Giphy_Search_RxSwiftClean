//
//  QueryHistoryStorage.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation
import RxSwift

protocol QueryHistoryStorage {
    func fetchQuery() -> Single<[String]>

    func saveQuery(of query: String, createdAt date: Date) -> Completable

    func removeQuery(of query: String) -> Completable
}
