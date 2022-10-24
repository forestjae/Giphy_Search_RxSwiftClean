//
//  Query+CoreDataProperties.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//
//

import Foundation
import CoreData


extension Query {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Query> {
        return NSFetchRequest<Query>(entityName: "Entity")
    }

    @NSManaged public var query: String?
    @NSManaged public var createdAt: Date?

}

extension Query : Identifiable {

}
