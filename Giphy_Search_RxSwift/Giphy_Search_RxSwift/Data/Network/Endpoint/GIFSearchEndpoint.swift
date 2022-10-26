//
//  GIFSearchEndpoint.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation

struct GIFSearchEndpoint: GiphyAPIEndpoint {
    typealias APIResponse = GIFSearchResponseDTO

    let method: HTTPMethod = .get
    var path: String {
        switch self.type {
        case .gif:
            return "gifs/search"
        case .sticker:
            return "stickers/search"
        }
    }
    let headers: [String : String]? = nil

    let body: Data? = nil

    let type: GIFType
    let query: String
    let imageSetConfiguration: String = "clips_grid_picker"
    let limit: Int = 10
    let offset: Int

    var queries: [String : String] {
        [
            "api_key": self.serviceKey,
            "q": self.query,
            "bundle": self.imageSetConfiguration,
            "limit": String(self.limit),
            "offset": String(self.offset)
        ]
    }
}
