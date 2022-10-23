//
//  GIFRepository.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation
import RxSwift

protocol GIFRepository {
    func fetchGIFPages(type: GIFType, query: String, offset: Int) -> Single<GIFPage> 
}
