//
//  GIFItemViewModel.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation

struct GIFItemViewModel: Hashable {
    var image: GIF
    var aspectRatio: Double
}

extension GIFItemViewModel {
    init(image: GIF) {
        self.image = image
        self.aspectRatio = image.gifBundle.originalHeight / image.gifBundle.originalWidth
    }
}
