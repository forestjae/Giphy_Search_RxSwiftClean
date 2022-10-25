//
//  AppCoordinator.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/25.
//

import Foundation

import UIKit

final class AppCoordinator: Coordinator {
    var finishDelegate: CoordinationFinishDelegate? = nil

    let identifier = UUID()

    var childCoordinator: [Coordinator] = []
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let rootViewController = UINavigationController()
        self.window.rootViewController = rootViewController
        self.window.makeKeyAndVisible()

        self.searchFlow(navigationController: rootViewController)
    }

    private func searchFlow(navigationController: UINavigationController) {
        let searchCoordinator = SearchCoordinator(
            navigationController: navigationController,
            finishDelegate: self
        )
        self.childCoordinator.append(searchCoordinator)
        searchCoordinator.start()
    }
}

extension AppCoordinator: CoordinationFinishDelegate { }
