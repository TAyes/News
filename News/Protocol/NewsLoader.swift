//
//  NewsLoader.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation
import UIKit
protocol NewsDataSource {
    func loadNews(fromURL: URL,compeletion: @escaping (Result<News, NetworkError>) -> Void)
}

final class NewsLoader: NewsDataSource {
    func loadNews(fromURL: URL, compeletion: @escaping (Result<News, NetworkError>) -> Void) {
        do {
            let networkManager = NetworkManager()
            // Request data from the backend
            networkManager.request(fromURL: fromURL) { (result: Result<News, Error>) in
                switch result {
                case .success(let response):
                    compeletion(.success(response))
                case .failure:
                    compeletion(.failure(.noData))
                }
             }
        }
    }
}

