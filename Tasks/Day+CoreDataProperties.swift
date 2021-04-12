//
//  Day+CoreDataProperties.swift
//  Tasks
//
//  Created by  on 4/11/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//
//

import Foundation
import CoreData


extension Day {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Day> {
        return NSFetchRequest<Day>(entityName: "Day")
    }

    @NSManaged public var day: String?
    @NSManaged public var daysTask: NSSet?

}

// MARK: Generated accessors for daysTask
extension Day {

    @objc(addDaysTaskObject:)
    @NSManaged public func addToDaysTask(_ value: Task)

    @objc(removeDaysTaskObject:)
    @NSManaged public func removeFromDaysTask(_ value: Task)

    @objc(addDaysTask:)
    @NSManaged public func addToDaysTask(_ values: NSSet)

    @objc(removeDaysTask:)
    @NSManaged public func removeFromDaysTask(_ values: NSSet)

}
