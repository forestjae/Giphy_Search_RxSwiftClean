//
//  QueryHistoryUseCase.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

protocol QueryHistoryUseCase {
    func fetchQueryHistory() -> Single<[String]>

    func saveQuery(of query: String) -> Completable

    func removeQuery(of query: String) -> Completable
}

class DefaultQueryHistoryUseCase: QueryHistoryUseCase {
    let queryHistoryRepository: QueryHistoryRepository

    init(queryHistoryRepository: QueryHistoryRepository) {
        self.queryHistoryRepository = queryHistoryRepository
    }

    func fetchQueryHistory() -> Single<[String]> {
        return self.queryHistoryRepository.fetchQueryHistory()
    }

    func saveQuery(of query: String) -> Completable {
        return self.queryHistoryRepository.saveQuery(of: query, createdAt: Date())
    }

    func removeQuery(of query: String) -> Completable {
        return self.queryHistoryRepository.removeQuery(of: query)
    }
}
