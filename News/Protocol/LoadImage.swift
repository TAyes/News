//
//  LoadImage.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Combine
import UIKit
protocol LoadImageDataSource {
    func loadImage(for news: NewsDetail) -> AnyPublisher<UIImage?, Never>
}
extension LoadImageDataSource {
    func loadImage(for news: NewsDetail) -> AnyPublisher<UIImage?, Never> {
        return Just(news.image)
         .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
             let url = URL(string: news.image ?? "")!
                 return ImageLoader.shared.loadImage(from: url)
         })
         .eraseToAnyPublisher()
     }
}
