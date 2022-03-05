//
//  News+Type.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation
enum NewType {
    case news
    case savednews
}
class SavedNews {
    var news: [NewsDetail] = []
    var newViewType: NewType?
}

