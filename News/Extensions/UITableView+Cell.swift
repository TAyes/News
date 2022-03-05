//
//  UITableView+Cell.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation
import UIKit

public extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UITableView {
    func dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        let tableView = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
        guard let cell = tableView as? T else {
            fatalError("Failed to cast cell to \(T.identifier)")
        }
        return cell
    }
}
