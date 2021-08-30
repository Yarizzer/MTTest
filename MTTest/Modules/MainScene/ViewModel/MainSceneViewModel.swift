//
//  MainSceneViewModel.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

protocol MainSceneViewModelType {
	var sceneTitle: String { get }
	var addTimerViewViewModel: AddTimerViewViewModelType { get }
	var timersViewViewModel: TimersViewViewModelType { get }
	
	func getAlertData(for type: MScAlertType) -> (title: String, message: String)
}

class MainSceneViewModel: MainSceneViewModelType {
	var sceneTitle: String { return AppCore.shared.globalLayer.appName }
	var addTimerViewViewModel: AddTimerViewViewModelType { return AddTimerViewViewModel() }
	var timersViewViewModel: TimersViewViewModelType { return TimersViewViewModel() }
	
	func getAlertData(for type: MScAlertType) -> (title: String, message: String) {
		switch type {
		case .validationError: return Constants.validationAlertData
		case .timerDidStored: return Constants.timerDidStoredAlertData
		}
	}
}

extension MainSceneViewModel {
	private struct Constants {
		static let validationAlertData = (title: "Error", message: "Time in seconds should contains only numeric characters (0-9)")
		static let timerDidStoredAlertData = (title: "Success", message: "Timer did stored in database")
	}
}
