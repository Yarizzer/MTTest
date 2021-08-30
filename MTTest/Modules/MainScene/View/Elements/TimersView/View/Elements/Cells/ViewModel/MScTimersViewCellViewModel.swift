//
//  MScTimersViewCellViewModel.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import Foundation

protocol MScTimersViewCellViewModelType {
	var expired: Publisher<Bool?> { get }
	
	var title: String { get }
	var timerIsPaused: Bool { get }
	var remainedTimeRepresentation: String? { get }
	
	func pauseResumeTimer()
}

class MScTimersViewCellViewModel {
	init(with model: TimerModel) {
		self.timerModel = model
		self.formatter = DateComponentsFormatter()
		formatter.allowedUnits = [.hour, .minute, .second]
		formatter.unitsStyle = .brief
	}
	
	var expired: Publisher<Bool?> = Publisher(nil)
	
	private var timerModel: TimerModel
	private var formatter: DateComponentsFormatter
}

extension MScTimersViewCellViewModel: MScTimersViewCellViewModelType {
	var title: String { return timerModel.name }
	var timerIsPaused: Bool { return timerModel.startMoment == nil }
	var remainedTimeRepresentation: String? {
		guard let valueFromStart = timerModel.startMoment?.timeIntervalSinceNow else { return formatter.string(from: TimeInterval(timerModel.secondsCount)) }
		
		let interval = valueFromStart + timerModel.secondsCount
		
		if interval < 0 {
			expired.value = true
		}
		
		return formatter.string(from: TimeInterval(interval))
	}
	
	func pauseResumeTimer() {
		AppCore.shared.databaseLayer.execute(command: .pause(withID: timerModel.id), completion: nil)
	}
}
