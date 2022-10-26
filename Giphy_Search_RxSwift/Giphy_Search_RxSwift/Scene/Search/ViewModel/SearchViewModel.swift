//
//  SearchViewModel.swift
//  Giphy_Search_RxSwift
//
//  Created by Lee Seung-Jae on 2022/10/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    weak var coordinator: SearchCoordinator?

    private let gifSearchUseCase: GIFSearchUseCase
    private let queryHistoryUseCase: QueryHistoryUseCase

    private var currentPage: Int = 0
    private var hasNextPage: Bool = false
    private let itemsPerPage: Int = 20
    private var gifs: [GIFItemViewModel] = []
    private var searchQuries: [String] = []


    init(gifSearchUseCase: GIFSearchUseCase, queryHistoryUseCase: QueryHistoryUseCase) {
        self.gifSearchUseCase = gifSearchUseCase
        self.queryHistoryUseCase = queryHistoryUseCase
    }

    struct Input {
        let viewWillAppear: Observable<Void>
        let searchQuery: Observable<String>
        let searchScope: Observable<Int>
        let searchButtonDidTap: Observable<Void>
        let loadNextPage: Observable<Void>
        let itemDidSelect: Observable<IndexPath>
        let queryDidSelect: Observable<IndexPath>
    }

    struct Output {
        let searchQueriesHistroyFetched: Driver<[String]>
        let imageSearched: Driver<[GIFItemViewModel]>
        let beginNewSearchSession: Driver<Void>
        let pushDetail: Driver<Void>
        let searchQueriesHistoryDidSaved: Driver<Void>
    }

    func transform(input: Input) -> Output {
        let searchScope = input.searchScope.compactMap { GIFType(index: $0) }
        let searchQueryDidSelect = input.queryDidSelect
            .map { self.searchQuries[$0.row] }

        let searchQuery = Observable.merge(input.searchQuery, searchQueryDidSelect)
            .filter { !$0.isEmpty }
            
        let didTapButton = input.searchButtonDidTap
        let loadNextPage = input.loadNextPage.filter { self.hasNextPage }

        let searchTrigger = Observable.merge(didTapButton, loadNextPage, searchQueryDidSelect.map { _ in })

        let newSearchSessionTrigger = Observable.combineLatest(searchScope, searchTrigger).share()

        let beginSearchSession = newSearchSessionTrigger.withLatestFrom(
            searchQuery,
            resultSelector: { ($0.0, $1) }
        ).share()

        let searchQueriesHistoryFetched = Observable.merge(
            input.viewWillAppear,
            beginSearchSession.map { _ in }
        )
            .flatMap { _ in
                self.queryHistoryUseCase.fetchQueryHistory()
            }
            .do(onNext: { self.searchQuries = $0 })
            .asDriver(onErrorJustReturn: [])

        let imageSearched = beginSearchSession.flatMapLatest { (gifType, query) in
            self.gifSearchUseCase.searchGIFImages(
                type: gifType,
                query: query,
                offset: self.currentPage
            )
        }
            .do(onNext: { page in
                self.currentPage += self.itemsPerPage
                self.hasNextPage = page.hasNextPage
            })
            .map { $0.gifs.map { GIFItemViewModel(image: $0) } }
            .do(onNext: { self.gifs.append(contentsOf: $0)})
            .asDriver(onErrorJustReturn: [])

        let searchQueriesHistoryDidSaved = beginSearchSession
            .withUnretained(self)
            .flatMap { (viewModel, search) in
                viewModel.queryHistoryUseCase.saveQuery(of: search.1)
            }
            .map { _ in }
            .asDriver(onErrorJustReturn: ())

        let beginNewSearchSession = Observable.merge(
            searchScope.map { _ in }.skip(1),
            didTapButton,
            searchQueryDidSelect.map { _ in }
        )
            .do(onNext: { _ in
                self.currentPage = 0
                self.hasNextPage = false
                self.gifs = []
            })
                .asDriver(onErrorJustReturn: ())

        let pushDetail = input.itemDidSelect
            .map { self.gifs[$0.row].image }
            .do { self.coordinator?.detailFlow(with: $0) }
            .map { _ in }
            .asDriver(onErrorJustReturn: ())

        return Output(
            searchQueriesHistroyFetched: searchQueriesHistoryFetched,
            imageSearched: imageSearched,
            beginNewSearchSession: beginNewSearchSession,
            pushDetail: pushDetail,
            searchQueriesHistoryDidSaved: searchQueriesHistoryDidSaved
        )
    }
}

// MARK: - Search Section/Item

enum SearchSection: Int {
    case searchResult = 0

    var title: String {
        switch self {
        case .searchResult:
            return "All The GIFs"
        }
    }
}

enum SearchItem: Hashable {
    case image(GIFItemViewModel)
}

// MARK: - SearchGuide Section/Item

enum SearchGuideSection: Int {
    case searchHistory = 0

    var title: String {
        switch self {
        case .searchHistory:
            return "Recent Searches"
        }
    }
}

enum SearchGuideItem: Hashable {
    case searchQueryHistory(String)
}
