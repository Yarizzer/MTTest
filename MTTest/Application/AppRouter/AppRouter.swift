//
//  AppRouter.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

protocol AppRoutable {
	func routeToMainScene()
}

class AppRouter {
	init(withWindow window: UIWindow) {
		self.window = window
	}
	
	private var window: UIWindow
}

extension AppRouter: AppRoutable {
	func routeToMainScene() {
		window.rootViewController = UINavigationController(rootViewController: MainSceneRouter.assembly())
		window.makeKeyAndVisible()
	}
}
