//
//  Navigator.swift
//  News
//
//  Created by shisheo portal on 05/03/2022.
//

import Foundation
import UIKit

final class AppNavigator {
    static let shared = AppNavigator()
    private static var navigator: UINavigationController!

    private init() {}

    func set(window: UIWindow) {
        AppNavigator.navigator = UINavigationController(rootViewController: Destination.newsList.controller)
        window.rootViewController = AppNavigator.navigator
        window.makeKeyAndVisible()
    }

    func push(_ dest: Destination) {
        AppNavigator.navigator.pushViewController(dest.controller, animated: true)
    }
}
