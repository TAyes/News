//
//  Destination.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation
import UIKit

enum Destination {
    case newsList
    case detail(NewsDetail,SavedNews)
    var controller: UIViewController {
        switch self {
        case .newsList:
            return NewsTableController()
        case let .detail(news, savedNews):
            return NewsDetailViewController(with: news, savedNews: savedNews)
        }
    }
}

