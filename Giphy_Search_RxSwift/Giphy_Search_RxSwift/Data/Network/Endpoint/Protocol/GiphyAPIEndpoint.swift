//
//  GiphyAPIEndpoint.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation

protocol GiphyAPIEndpoint: APIEndpoint, GiphyAPIRequestSpec { }

protocol GiphyAPIRequestSpec {
    var serviceKey: String { get }
}

extension GiphyAPIRequestSpec {
    var baseURL: URL? {
        return URL(string: "https://api.giphy.com/v1")
    }

    var serviceKey: String {
        return "Zo01seUJhBkXATpgWm2lnL4m2b07xREM"
    }
}
