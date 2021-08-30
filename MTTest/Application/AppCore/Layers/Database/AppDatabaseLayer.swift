//
//  AppDatabaseLayer.swift
//  MTTest
//
//  Created byYaroslav Abaturov on 28.08.2021.
//

import UIKit
import CoreData

class AppDatabaseLayer {
	init() {
		guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
			fatalError("UIApplication.shared.delegate casting to AppDelegate failed")
		}
		
		self.context = delegate.persistentContainer.viewContext
	}
	
	//MARK: Session
	func prepareSession() {
		removeExpiredItems()
		updateData()
	}
	
	//MARK: - Context
	private func saveContext() {
		do {
			try context.save()
		} catch {
			writeLog(type: .coreDataError, message: error.localizedDescription)
		}
	}
	
	//MARK: - System
	private func configureFetchRequest(with type: AppDatabaseLayerFetchRequestType) -> NSFetchRequest<TimerEntity> {
		switch type {
		case .full: return TimerEntity.fetchRequest()
		case .id(let param):
			let fetchRequest: NSFetchRequest<TimerEntity> = TimerEntity.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: Constants.uuidPredicateFormat, param)
			return fetchRequest
		case .expiredItems:
			let fetchRequest: NSFetchRequest<TimerEntity> = TimerEntity.fetchRequest()
			fetchRequest.predicate = NSPredicate(format: Constants.expiredItemsPredicateFormat)
			return fetchRequest
		}
	}
	
	private func removeExpiredItems() {
		do {
			try context.fetch(configureFetchRequest(with: .expiredItems)).forEach { item in
				guard let intervalSinceNow = item.startMoment?.timeIntervalSinceNow else { return }
				
				//Searching not actual timers (at least 10 sec)
				if (intervalSinceNow + item.secondsCount) < 10 {
					context.delete(item)
				}
			}
			
			try context.save()
		} catch {
			writeLog(type: .coreDataError, message: error.localizedDescription)
		}
	}
	
	private func updateData() {
		var valueToReturn = [TimerModel]()
		do {
			let result = try context.fetch(configureFetchRequest(with: .full))
			
			if !result.isEmpty {
				result.forEach { valueToReturn.append(TimerModel(with: $0)) }
			}
		} catch {
			writeLog(type: .coreDataError, message: error.localizedDescription)
		}
		
		self.timerModels = valueToReturn
	}
	
	//MARK: - Publishers
	var didFetchedNewData: Publisher<Bool?> = Publisher(nil)
	
	//MARK: - props
	private let context: NSManagedObjectContext
	private var timerModels: [TimerModel]? {
		didSet {
			didFetchedNewData.value = true
		}
	}
}

extension AppDatabaseLayer: AppDatabaseLayerType {
	var data: [TimerModel]? { return timerModels }
	
	func execute(command type: AppDatabaseLayerCommandType, completion: ((Bool) -> ())?) {
		switch type {
		case .create(let model):
			guard let entity = NSEntityDescription.entity(forEntityName: Constants.entityName, in: context),
				  let entityObject = NSManagedObject(entity: entity, insertInto: context) as? TimerEntity else { return }

			entityObject.name = model.name
			entityObject.uuid = model.id
			entityObject.secondsCount = model.secondsCount
			entityObject.startMoment = model.startMoment
			
			saveContext()
			
			timerModels?.append(model)
			
			completion?(true)
		default:
			do {
				switch type {
				case .remove(let id):
					let result = try context.fetch(configureFetchRequest(with: .id(param: id)))
					result.forEach { context.delete($0) }
				case .pause(let id):
					let result = try context.fetch(configureFetchRequest(with: .id(param: id)))
					result.forEach {
						//Reset secondsCount if not paused
						if let newStartMoment = $0.startMoment?.timeIntervalSinceNow {
							$0.secondsCount += newStartMoment
						}
						//Start moment == nil if paused
						$0.startMoment = ($0.startMoment) == nil ? Date() : nil
					}
				default: break
				}
				
				try context.save()
				
				updateData()
				
				completion?(true)
			} catch {
				writeLog(type: .coreDataError, message: error.localizedDescription)
			}
		}
	}
}

extension AppDatabaseLayer {
	private struct Constants {
		static let entityName = "TimerEntity"
		static let uuidPredicateFormat = "uuid == %@"
		static let expiredItemsPredicateFormat = "startMoment != nil"
	}
}
