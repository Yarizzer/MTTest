//
//  MainSceneInteractor.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

class MainSceneInteractor {
	init(withRouter router: MainSceneRoutable, presenter: MainScenePresentable) {
		self.router = router
		self.presenter = presenter
	}

	private var router: MainSceneRoutable
	private var presenter: MainScenePresentable
}

extension MainSceneInteractor: MainSceneInteractable {
	func makeRequest(requestType: MainSceneInteractorRequest.RequestType) {
		switch requestType {
		case .initialSetup: presenter.response(responseType: .initialSetup)
		case .showAlert(let type): presenter.response(responseType: .showAlert(withType: type))
		}
	}
}
