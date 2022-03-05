//
//  News.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation

// MARK: - News
struct News: Codable {
    let pagination: Pagination?
    let data: [NewsDetail]?
}

// MARK: - Datum
struct NewsDetail: Codable {
    let title, datumDescription: String?
    let image: String?
    let publishedAt: String?

    enum CodingKeys: String, CodingKey {
        case title
        case datumDescription = "description"
        case image
        case publishedAt = "published_at"
    }
}
// MARK: - Pagination
struct Pagination: Codable {
    let limit, offset, count, total: Int?
}

