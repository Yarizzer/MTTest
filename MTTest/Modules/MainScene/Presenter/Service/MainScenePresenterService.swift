//
//  MainScenePresenterService.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import UIKit

protocol MainScenePresenterServiceType {
	var model: MainSceneViewModelType { get }
}

class MainScenePresenterService {
	init(withModel model: MainSceneViewModelType) {
		self.viewModel = model
	}
	
	private var viewModel: MainSceneViewModelType
}

extension MainScenePresenterService: MainScenePresenterServiceType {
	var model: MainSceneViewModelType { return viewModel }
}
