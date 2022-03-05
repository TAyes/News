//
//  Date+Time.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation

extension String {
    func getIsoDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
}
extension Date {
    func getDateTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
