//
//  DetailCoordinator.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/25.
//

import UIKit

final class DetailCoordinator: Coordinator {
    weak var finishDelegate: CoordinationFinishDelegate?
    let identifier = UUID()
    var childCoordinator: [Coordinator] = []

    private weak var navigationController: UINavigationController?
    private let image: GIF

    init(
        navigationController: UINavigationController?,
        image: GIF,
        finishDelegate: CoordinationFinishDelegate
    ) {
        self.navigationController = navigationController
        self.image = image
        self.finishDelegate = finishDelegate
    }

    func start() {
        let detailViewController = DetailViewController()
        let detailViewModel = DetailViewModel(
            image: self.image,
            favoriteGIFUseCase: DefaultFavoriteGIFUseCase(
                favoriteGIFRepository: DefaultFavoriteGIFRepository(
                    favoriteStorage: CoreDataFavoriteStorage()
                )
            )
        )
        detailViewModel.coordinator = self
        detailViewController.viewModel = detailViewModel
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
