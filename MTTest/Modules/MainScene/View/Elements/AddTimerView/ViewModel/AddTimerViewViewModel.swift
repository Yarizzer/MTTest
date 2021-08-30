//
//  AddTimerViewViewModel.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import Foundation

protocol AddTimerViewViewModelType {
	var timerNameTFPlaceholder: String { get }
	var timeInSecondsTFPlaceholder: String { get }
	func storeTimer(with data: (name: String?, seconds: String?), completion: @escaping (Bool) -> ())
}

class AddTimerViewViewModel: AddTimerViewViewModelType {
	var timerNameTFPlaceholder: String { return Constants.timerNameTFPlaceholderValue }
	var timeInSecondsTFPlaceholder: String { return Constants.timeInSecondsTFPlaceholderValue }
	
	func storeTimer(with data: (name: String?, seconds: String?), completion: @escaping (Bool) -> ()) {
		guard let seconds = data.seconds, let secondsCount = Double(seconds) else {
			completion(false)
			return
		}
		
		let model = TimerModel(id: UUID().uuidString,
							   name: data.name ?? Constants.newTimerNamePlaceholder,
							   secondsCount: secondsCount)
		
		AppCore.shared.databaseLayer.execute(command: .create(withModel: model)) { completion($0) }
	}
}

extension AddTimerViewViewModel {
	private struct Constants {
		static let timerNameTFPlaceholderValue = "Название таймера"
		static let timeInSecondsTFPlaceholderValue = "Время в секундах"
		static let newTimerNamePlaceholder = "Timer"
	}
}
