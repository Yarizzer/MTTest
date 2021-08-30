//
//  TimerModel.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 28.08.2021.
//

import Foundation

struct TimerModel {
	//With props
	init(id: String, name: String, secondsCount: Double) {
		self.id = id
		self.name = name
		self.secondsCount = secondsCount
		self.startMoment = Date()
	}
	
	//With coredata entity
	init(with entity: TimerEntity) {
		self.id = entity.uuid
		self.name = entity.name
		self.secondsCount = entity.secondsCount
		self.startMoment = entity.startMoment
	}
	
	let name: String
	let secondsCount: Double
	let startMoment: Date?
	let id: String
}
