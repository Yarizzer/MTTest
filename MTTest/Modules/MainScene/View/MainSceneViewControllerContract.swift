//
//  MainSceneViewControllerContract.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

protocol MainSceneViewControllerType {
    func update(viewModelDataType: MainSceneViewControllerViewModel.ViewModelDataType)
}

struct MainSceneViewControllerViewModel {
    enum ViewModelDataType {
        case initialSetup(with: MainSceneViewModelType)
    }
}
