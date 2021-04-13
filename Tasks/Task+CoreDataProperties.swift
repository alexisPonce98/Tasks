//
//  Task+CoreDataProperties.swift
//  Tasks
//
//  Created by  on 4/12/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var destination: String?
    @NSManaged public var time: String?
    @NSManaged public var title: String?
    @NSManaged public var image: Data?
    @NSManaged public var taskDay: Day?

}
