//
//  QueryHistoryUseCase.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

protocol QueryHistoryUseCase {
    func fetchQueryHistory(type: GIFType, query: String, offset: Int) -> Observable<[String]>

    func saveQuery(of query: String, identifier: String) -> Completable

    func removeQuery(of query: String, identifier: String) -> Completable
}

class DefaultQueryHistoryUseCase: QueryHistoryUseCase {
    let queryHistoryRepository: QueryHistoryRepository

    init(queryHistoryRepository: QueryHistoryRepository) {
        self.queryHistoryRepository = queryHistoryRepository
    }

    func fetchQueryHistory(type: GIFType, query: String, offset: Int) -> Observable<[String]> {
        return self.queryHistoryRepository.fetchQueryHistory()
    }

    func saveQuery(of query: String, identifier: String) -> Completable {
        return self.saveQuery(of: query, identifier: identifier)
    }

    func removeQuery(of query: String, identifier: String) -> Completable {
        return self.removeQuery(of: query, identifier: identifier)
    }
}
