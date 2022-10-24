//
//  GIFSearchResponseDTO+Mapping.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation

extension GIFSearchResponseDTO {
    func toGifPage() -> GIFPage {
        let offset = self.pagination.offset
        let target = min(self.pagination.totalCount, 4999)
        let isNextPage = offset < target
        return GIFPage(
            offset: offset,
            hasNextPage: isNextPage,
            gifs: self.results.compactMap { $0.toGif() }
        )
    }
}

extension GIFResponse {
    func toGif() -> GIF? {
        guard let type = GIFType(rawValue: self.type) else {
            return nil
        }

        return GIF(
            identifier: self.identifier,
            title: self.title,
            user: self.user?.toUser(),
            gifBundle: self.images.toGIFBundle(),
            source: self.source == "" ? nil : self.source,
            type: type
        )
    }
}

extension UserResponse {
    func toUser() -> User {
        return User(
            name: self.username,
            displayedName: self.displayName,
            description: self.userDescription,
            avatarImageURL: self.avatarURL,
            isVerified: self.isVerified
        )
    }
}

extension GIFSetResponse {
    func toGIFBundle() -> GIFBundle {
        let originalWidth = Double(self.original.width) ?? 100
        let originalHeight = Double(self.original.height) ?? 100
        return GIFBundle(
            imageURL: self.original.url,
            originalWidth: originalWidth,
            originalHeight: originalHeight,
            originalMp4Image: self.original.mp4,
            gridImageURL: self.fixedWidth.url,
            gridMp4URL: self.fixedWidth.mp4
        )
    }
}
