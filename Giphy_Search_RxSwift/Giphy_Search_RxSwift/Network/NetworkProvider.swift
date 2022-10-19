//
//  NetworkProvider.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/09/18.
//

import Foundation

protocol NetworkProvider {
    var session: URLSession { get }
}

