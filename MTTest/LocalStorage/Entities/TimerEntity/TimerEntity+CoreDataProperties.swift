//
//  TimerEntity+CoreDataProperties.swift
//  MTTest
//
//  Created by Yaroslav Abaturov on 29.08.2021.
//
//

import Foundation
import CoreData


extension TimerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimerEntity> {
        return NSFetchRequest<TimerEntity>(entityName: "TimerEntity")
    }

    @NSManaged public var secondsCount: Double
    @NSManaged public var name: String
    @NSManaged public var uuid: String
    @NSManaged public var startMoment: Date?

}

extension TimerEntity : Identifiable {

}
