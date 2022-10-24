//
//  CoreDataFavoriteStorage.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation
import RxSwift

class CoreDataFavoriteStorage: FavoriteStorage {
    private let coreDataProvider: CoreDataProvider

    init(coreDataProvider: CoreDataProvider = CoreDataProvider.shared) {
        self.coreDataProvider = coreDataProvider
    }

    func fetchFavorites() -> Single<[String]> {
        let sort = NSSortDescriptor(key: "createdAt", ascending: false)
        let request = Favorite.fetchRequest()
        request.sortDescriptors = [sort]

        return Single.create { single in
            do {
                let result = try self.coreDataProvider.fetch(request: request)
                    .compactMap { $0.identifier }
                single(.success(result))
            } catch let error {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }

    func isFavorite(of identifier: String) -> Single<Bool> {
        return Single.create { single in
            do {
                let result = try self.coreDataProvider.fetch(request: Favorite.fetchRequest())
                    .map { $0.identifier }
                single(.success(result.contains(identifier)))
            } catch let error {
                single(.failure(error))
            }
            return Disposables.create()
        }
    }

    func setFavorite(for identifier: String, createdAt date: Date = Date()) -> Completable {
        return Completable.create { completable in
            do {
                try self.coreDataProvider.create(
                    entityName: String(describing: Favorite.self),
                    values: [
                        "identifier" : identifier,
                        "createdAt" : date
                    ]
                )
                completable(.completed)
            } catch let error {
                completable(.error(error))
            }
            return Disposables.create()
        }
    }

    func setUnfavorite(for identifier: String) -> Completable {
        let predicate = NSPredicate(format: "identifier == %@", identifier)

        return Completable.create { completable in
            do {
                let objects = try self.coreDataProvider.fetch(
                    request: Favorite.fetchRequest(),
                    predicate: predicate
                )

                try objects.forEach {
                    try self.coreDataProvider.delete(object: $0)
                }

                completable(.completed)
            } catch let error {
                completable(.error(error))
            }
            return Disposables.create()
        }
    }
}
