//
//  MainScenePresenterContract.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

protocol MainScenePresentable {
	func response(responseType: MainScenePresenterResponse.MainSceneResponseType)
}

struct MainScenePresenterResponse {
	enum MainSceneResponseType {
		case initialSetup
		case showAlert(withType: MScAlertType)
		case releaseView
	}
}
