//
//  GIFSearchUseCase.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

protocol GIFSearchUseCase {
    func searchGIFImages(type: GIFType, query: String, offset: Int) -> Single<GIFPage>
}

class DefaultGIFSearchUseCase: GIFSearchUseCase {
    private let gifRepository: GIFRepository

    init(gifRepository: GIFRepository) {
        self.gifRepository = gifRepository
    }

    func searchGIFImages(type: GIFType, query: String, offset: Int) -> Single<GIFPage> {
        return self.gifRepository.fetchGIFPages(type: type, query: query, offset: offset)
    }
}
