//
//  Coordinator.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set }
    var finishDelegate: CoordinationFinishDelegate? { get }
    var identifier: UUID { get }

    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        self.childCoordinator.removeAll()
        self.finishDelegate?.coordinationDidFinish(child: self)
    }
}
