//
//  DefaultQueryHistoryRepository.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

class DefaultQueryHistoryRepository: QueryHistoryRepository {
    let queryHistoryStorage: QueryHistoryStorage

    init(queryHistoryStorage: QueryHistoryStorage) {
        self.queryHistoryStorage = queryHistoryStorage
    }

    func fetchQueryHistory() -> Single<[String]> {
        return self.queryHistoryStorage.fetchQuery()
    }

    func saveQuery(of query: String, createdAt date: Date) -> Completable {
        return self.queryHistoryStorage.saveQuery(of: query, createdAt: date)
    }

    func removeQuery(of query: String) -> Completable {
        return self.queryHistoryStorage.removeQuery(of: query)
    }
}
