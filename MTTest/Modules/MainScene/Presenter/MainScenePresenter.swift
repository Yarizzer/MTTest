//
//  MainScenePresenter.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

class MainScenePresenter {
	init(for view: MainSceneViewControllerType, service: MainScenePresenterServiceType) {
		self.viewController = view
		self.service = service
	}
	
	private var viewController: MainSceneViewControllerType?
	private var service: MainScenePresenterServiceType
}

extension MainScenePresenter: MainScenePresentable {
	func response(responseType: MainScenePresenterResponse.MainSceneResponseType) {
		switch responseType {
		case .initialSetup: viewController?.update(viewModelDataType: .initialSetup(with: service.model))
		case .showAlert(let type): viewController?.update(viewModelDataType: .showAlert(withData: service.getAlertData(for: type)))
		case .releaseView: viewController = nil
		}
	}
}
