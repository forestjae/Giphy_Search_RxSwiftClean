//
//  GIFBundle.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation

struct GIFBundle {
    let imageURL: String
    let originalWidth: Double
    let originalHeight: Double
    let originalMp4Image: String
    let gridImageURL: String
    let gridMp4URL: String
}

extension GIFBundle: Hashable { }
