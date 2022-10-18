//
//  NetworkError.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/09/18.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case serverError
    case invalidResponse
    case invalidData
    case parsingError
}
