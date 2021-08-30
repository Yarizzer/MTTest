//
//  MainSceneInteractorContract.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

protocol MainSceneInteractable {
	func makeRequest(requestType: MainSceneInteractorRequest.RequestType)
}

struct MainSceneInteractorRequest {
	enum RequestType {
		case initialSetup
	}
}
