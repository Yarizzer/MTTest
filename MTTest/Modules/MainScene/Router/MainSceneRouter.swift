//
//  MainSceneRouter.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

protocol MainSceneRoutable {
	static func assembly() -> UIViewController
}

class MainSceneRouter {
	private weak var view: MainSceneViewController?
}

extension MainSceneRouter: MainSceneRoutable {
	static func assembly() -> UIViewController {
		let router 				= MainSceneRouter()
		let vc                  = MainSceneViewController()
		let viewModel           = MainSceneViewModel()
		let presenterService    = MainScenePresenterService(withModel: viewModel)
		let presenter           = MainScenePresenter(for: vc, service: presenterService)
		let interactor          = MainSceneInteractor(withRouter: router, presenter: presenter)
		
		router.view = vc
		
		router.view?.interactor = interactor
		
		guard let view = router.view else {
			fatalError("cannot instantiate \(String(describing: MainSceneViewController.self))")
		}
		
		return view
	}
}
