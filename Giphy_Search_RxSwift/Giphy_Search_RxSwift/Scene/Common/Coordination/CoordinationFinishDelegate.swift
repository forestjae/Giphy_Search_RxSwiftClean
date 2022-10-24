//
//  CoordinationFinishDelegate.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation

protocol CoordinationFinishDelegate: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    func coordinationDidFinish(child: Coordinator)
}

extension CoordinationFinishDelegate {
    func coordinationDidFinish(child: Coordinator) {
        self.childCoordinator = self.childCoordinator.filter { $0.identifier != child.identifier}
    }
}
