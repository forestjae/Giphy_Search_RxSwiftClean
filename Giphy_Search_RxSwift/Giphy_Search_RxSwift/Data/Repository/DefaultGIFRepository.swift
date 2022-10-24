//
//  DefaultGIFRepository.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

class DefaultGIFRepository: GIFRepository {
    let networkProvider: DefaultNetworkProvider

    init(networkProvider: DefaultNetworkProvider) {
        self.networkProvider = networkProvider
    }

    func fetchGIFPages(type: GIFType, query: String, offset: Int) -> Single<GIFPage> {
        let request = GIFSearchEndpoint(type: type, query: query, offset: offset)
        return self.networkProvider.rx.request(request)
            .map { $0.toGifPage() }
    }
}
