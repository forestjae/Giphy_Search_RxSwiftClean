//
//  NetworkError.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/09/18.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case serverError(description: String)
    case invalidResponse
    case invalidStatusCode(Int, data: Data)
    case invalidData
    case parsingError(description: String, data: Data)
}
