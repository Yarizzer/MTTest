//
//  MainScenePresenterContract.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol MainScenePresenterable {
    func response(responseType: MainScenePresenterResponse.MainSceneResponseType)
}

struct MainScenePresenterResponse {
    enum MainSceneResponseType {
        case initialSetup
    }
}
