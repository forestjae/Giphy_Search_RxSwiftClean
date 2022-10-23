//
//  GIF.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation

struct GIF {
    let identifier: String
    let title: String
    let user: User?
    let gifBundle: GIFBundle
    let source: String?
    let type: GIFType
}

extension GIF: Hashable { }

struct GIFPage {
    let offset: Int
    let hasNextPage: Bool
    let gifs: [GIF]
}
