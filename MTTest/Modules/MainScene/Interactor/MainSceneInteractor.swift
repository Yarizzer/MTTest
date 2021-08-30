//
//  MainSceneInteractor.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

class MainSceneInteractor {
	init(withRouter router: MainSceneRoutable, presenter: MainScenePresentable, service: MainSceneInteractorServiceType) {
		self.router = router
		self.presenter = presenter
		self.service = service
	}

	private var router: MainSceneRoutable
	private var presenter: MainScenePresentable
	private var service: MainSceneInteractorServiceType
}

extension MainSceneInteractor: MainSceneInteractable {
	func makeRequest(requestType: MainSceneInteractorRequest.RequestType) {
		switch requestType {
		case .initialSetup: presenter.response(responseType: .initialSetup)
		}
	}
}
