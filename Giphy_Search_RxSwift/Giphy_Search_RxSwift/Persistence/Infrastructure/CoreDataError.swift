//
//  CoreDataError.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation

enum DataSourceError: Error {
    case decodingFailure
    case jsonNotFound
    case coreDataSaveFailure(NSError)
}
