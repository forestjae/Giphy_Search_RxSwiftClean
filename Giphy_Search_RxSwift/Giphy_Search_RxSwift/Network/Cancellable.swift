//
//  Cancellable.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/22.
//

import Foundation

protocol Cancellable {
    func cancel()
}

extension URLSessionTask: Cancellable { }
