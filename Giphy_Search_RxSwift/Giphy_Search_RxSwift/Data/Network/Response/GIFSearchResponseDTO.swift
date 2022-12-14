//
//  GIFSearchResponseDTO.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation

struct GIFSearchResponseDTO: Decodable {
    let results: [GIFResponse]
    let pagination: Pagination

    enum CodingKeys: String, CodingKey {
        case results = "data"
        case pagination
    }
}


struct GIFResponse: Decodable {
    let type: String
    let identifier: String
    let username: String
    let title: String
    let images: GIFSetResponse
    let user: UserResponse?
    let source: String?

    enum CodingKeys: String, CodingKey {
        case type
        case identifier = "id"
        case username
        case title
        case images
        case user
        case source = "source_tld"
    }
}

struct Pagination: Decodable {
    let totalCount: Int
    let count: Int
    let offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count
        case offset
    }
}

struct UserResponse: Decodable {
    let avatarURL: String
    let bannerImage: String
    let bannerURL: String
    let profileURL: String
    let username: String
    let displayName: String
    let userDescription: String
    let instagramURL: String
    let websiteURL: String
    let isVerified: Bool

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case bannerImage = "banner_image"
        case bannerURL = "banner_url"
        case profileURL = "profile_url"
        case username
        case displayName = "display_name"
        case userDescription = "description"
        case instagramURL = "instagram_url"
        case websiteURL = "website_url"
        case isVerified = "is_verified"
    }
}

struct GIFSetResponse: Decodable {
    let original: OriginalImageResponse
    let fixedWidth: FixedWidthImageResponse

    enum CodingKeys: String, CodingKey {
        case original
        case fixedWidth = "fixed_width"
    }
}

struct OriginalImageResponse: Decodable {
    let height: String
    let width: String
    let size: String
    let url: String
    let mp4Size: String
    let mp4: String
    let webpSize: String
    let webp: String
    let frames: String

    enum CodingKeys: String, CodingKey {
        case height
        case width
        case size
        case url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp
        case frames
    }
}

struct FixedWidthImageResponse: Decodable {
    let height: String
    let width: String
    let size: String
    let url: String
    let mp4Size: String
    let mp4: String
    let webpSize: String
    let webp: String

    enum CodingKeys: String, CodingKey {
        case height
        case width
        case size
        case url
        case mp4Size = "mp4_size"
        case mp4
        case webpSize = "webp_size"
        case webp
    }
}

extension GIFType: Decodable { }
