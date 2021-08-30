//
//  MainScenePresenterService.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

protocol MainScenePresenterServiceType {
	var model: MainSceneViewModelType { get }
	
	func getAlertData(for type: MScAlertType) -> (title: String, message: String)
}

class MainScenePresenterService {
	init(withModel model: MainSceneViewModelType) {
		self.viewModel = model
	}
	
	private var viewModel: MainSceneViewModelType
}

extension MainScenePresenterService: MainScenePresenterServiceType {
	var model: MainSceneViewModelType { return viewModel }
	
	func getAlertData(for type: MScAlertType) -> (title: String, message: String) {
		return model.getAlertData(for: type)
	}
}
