//
//  NewsViewModel.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation

protocol NewsViewModelType {
    var newsList: Observable<[NewsDetail]> { get }
    var error: Observable<String?> { get }
    var isLoading: Observable<Bool> { get }
    var savedNews: SavedNews { get set }
    var viewNewsType: NewType { get }
    func showNewsList(for list: NewType)
    func loadMoreData()
}

final class NewsViewModel: NewsViewModelType {
    var viewNewsType: NewType = .news
    private let newsLoader: NewsDataSource
    var savedNews: SavedNews = SavedNews()
    let newsList: Observable<[NewsDetail]> = .init([])
    let isLoading: Observable<Bool> = .init(false)
    let error: Observable<String?> = .init(nil)
    var newsData: News?
    var pageNo = 0
    let limit = 50
    private var news: [NewsDetail] = []
    private var isDataReady = true {
        didSet {
            guard isDataReady else { return }
        }
    }
    private var limitExceeded: Bool {
        guard ((self.newsData?.pagination?.limit ?? 0) * pageNo) < (self.newsData?.pagination?.total ?? 1) else {
            return true
        }
        return false
    }
    init(newsLoader: NewsDataSource = NewsLoader()) {
        self.newsLoader = newsLoader
        savedNews.newViewType = .news
        loadMoreData()
        
    }
    func loadMoreData() {
        guard !limitExceeded, viewNewsType == .news, self.isDataReady else { return }
        loadData(page: pageNo)
        pageNo += 1
    }
    
    func showNewsList(for list: NewType) {
        viewNewsType = list
        savedNews.newViewType = list
        var news: [NewsDetail] = []
        switch list {
        case .news:
            news = self.news
        case .savednews:
            news = self.savedNews.news
        }
        self.newsList.next(news)
    }
}

private extension NewsViewModel {
    func loadData(page: Int) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            guard let url = URL(string: NetworkManager.baseUrl + "news?access_key=eb9dcc5a1924eb05925ba27586862e59&offset=\(page*self.limit)&limit=\(self.limit)") else { fatalError("Invalid URL") }
            self.isDataReady = false
            self.newsLoader.loadNews(fromURL: url) { data in
                switch data {
                case let .success(response):
                    self.newsData = response
                    self.news.append(contentsOf: response.data ?? [])
                    self.newsList.next(self.news)
                    self.isLoading.next(false)
                case let .failure(error):
                    self.error.next(error.localizedDescription)
                }
                self.isDataReady = true
            }
        }
    }
}

