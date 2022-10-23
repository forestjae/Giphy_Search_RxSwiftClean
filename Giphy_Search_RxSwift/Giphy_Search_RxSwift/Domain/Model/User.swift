//
//  User.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/23.
//

import Foundation

struct User {
    let name: String
    let displayedName: String
    let description: String
    let avatarImageURL: String
    let isVerified: Bool
}

extension User: Hashable { }
