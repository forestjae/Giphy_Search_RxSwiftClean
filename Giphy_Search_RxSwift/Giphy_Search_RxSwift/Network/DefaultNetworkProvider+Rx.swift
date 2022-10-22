//
//  DefaultNetworkProvider+Rx.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/22.
//

import Foundation
import RxSwift

extension DefaultNetworkProvider: ReactiveCompatible { }

extension Reactive where Base: DefaultNetworkProvider {
    func request<T: APIEndpoint>(_ request: T) -> Single<T.APIResponse> {
        return Single.create { single in
            let task = self.base.request(request) { result in
                switch result {
                case .success(let response):
                    single(.success(response))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
