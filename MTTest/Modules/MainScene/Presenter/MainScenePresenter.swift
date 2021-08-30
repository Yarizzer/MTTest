//
//  MainScenePresenter.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

class MainScenePresenter {
    init(for view: MainSceneViewControllerType, service: MainScenePresenterServiceType) {
        self.viewController = view
        self.service = service
    }
    
    private var viewController: MainSceneViewControllerType
    private var service: MainScenePresenterServiceType
}

extension MainScenePresenter: MainScenePresenterable {
    func response(responseType: MainScenePresenterResponse.MainSceneResponseType) {
        switch responseType {
        case .initialSetup: print("Presenter: initial setup")
        }
    }
}
