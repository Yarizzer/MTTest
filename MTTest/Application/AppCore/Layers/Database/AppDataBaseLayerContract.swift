//
//  AppDataBaseLayerContract.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 30.08.2021.
//

import Foundation

protocol AppDatabaseLayerType {
	func prepareSession()
	
	var didFetchedNewData: Publisher<Bool?> { get }
	var data: [TimerModel]? { get }
	
	func execute(command type: AppDatabaseLayerCommandType, completion: ((Bool) -> ())?)
}

enum AppDatabaseLayerFetchRequestType {
	case full, id(param: String), expiredItems
}

enum AppDatabaseLayerCommandType {
	case create(withModel: TimerModel), remove(withID: String), pause(withID: String)
}
