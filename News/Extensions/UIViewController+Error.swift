//
//  UIViewController+Error.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation
import UIKit

public extension UIViewController {
    func show(error: String) {
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

