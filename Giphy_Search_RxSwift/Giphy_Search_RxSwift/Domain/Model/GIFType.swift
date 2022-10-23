//
//  GIFType.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation

enum GIFType: String, CaseIterable {
    case normal
    case sticker

    var description: String {
        switch self {
        case .normal:
            return "GIF"
        case .sticker:
            return "Sticker"
        }
    }
}

extension GIFType {
    init?(index: Int) {
        switch index {
        case 0:
            self = .normal
        case 1:
            self = .sticker
        default:
            return nil
        }
    }
}
