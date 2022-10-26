//
//  SearchCoordinator.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import UIKit

final class SearchCoordinator: Coordinator {
    weak var finishDelegate: CoordinationFinishDelegate?
    let identifier: UUID = UUID()
    var childCoordinator: [Coordinator] = []

    private weak var navigationController: UINavigationController?

    init(
        navigationController: UINavigationController,
        finishDelegate: CoordinationFinishDelegate
    ) {
        self.navigationController = navigationController
        self.finishDelegate = finishDelegate
    }

    func start() {
        let searchViewController = SearchViewController()
        let searchViewModel = SearchViewModel(
            gifSearchUseCase: DefaultGIFSearchUseCase(
                gifRepository: DefaultGIFRepository(
                    networkProvider: DefaultNetworkProvider()
                )
            ),
            queryHistoryUseCase: DefaultQueryHistoryUseCase(
                queryHistoryRepository: DefaultQueryHistoryRepository(
                    queryHistoryStorage: CoreDataQueryHistoryStorage()
                )
            )
        )
        searchViewModel.coordinator = self
        searchViewController.viewModel = searchViewModel
        self.navigationController?.viewControllers = [searchViewController]
    }

    func detailFlow(with image: GIF) {
        let detailCoordinator = DetailCoordinator(
            navigationController: self.navigationController,
            image: image,
            finishDelegate: self
        )
        self.childCoordinator.append(detailCoordinator)
        detailCoordinator.start()
    }
}

extension SearchCoordinator: CoordinationFinishDelegate { }
