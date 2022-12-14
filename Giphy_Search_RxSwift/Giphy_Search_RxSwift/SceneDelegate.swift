//
//  SceneDelegate.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/08/09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }

        self.window = UIWindow(windowScene: windowScene)

        guard let window = self.window else {
            return
        }

        self.appCoordinator = AppCoordinator(window: window)
        self.appCoordinator?.start()
    }
}
