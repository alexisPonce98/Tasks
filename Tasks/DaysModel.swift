//
//  DaysModel.swift
//  Tasks
//
//  Created by  on 4/8/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DaysModel{
    var tasks:[Task] = [Task]()
    var day  = ""
    let manage:NSManagedObjectContext?
    
    init(context:NSManagedObjectContext){
        manage = context
    }
    
    func saveDay(day:String?){
        let ent = NSEntityDescription.entity(forEntityName: "Day", in: manage!)
        let dayy = Day(entity: ent!, insertInto: manage!)
        if(day != nil){
            dayy.day = day!
        }
        dayy.task = nil
        do{
            try manage?.save()
        }catch let error{
            print("This is the erro in single day save \(error.localizedDescription)")
        }
    }
    
    func saveContext(task:[Task]?, day:String?){
        let ent = NSEntityDescription.entity(forEntityName: "Day", in: manage!)
        let dayy = Day(entity: ent!, insertInto: manage!)
        if(task != nil){
            self.tasks = task!;
            dayy.task = task
            
        }
        if(day != nil){
            self.day = day!
            dayy.day = day!
        }
        
        do{
            try manage?.save()
        }catch let error{
            print("this is the error in DayModel saveContext \(error.localizedDescription.description)")
        }
    }
    
    func fetch() -> [Day]{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let result = try? manage?.fetch(fetch) as? [Day]
        return result!
    }
    
    func fetchRecordCount()->Int{
        let fetchd = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let sort = NSSortDescriptor.init(key: "Day", ascending: true)
        fetchd.sortDescriptors = [sort]
        let result = try? manage?.fetch(fetchd) as? [Day]
        let count = result!.count
        return count
        
    }
    
    func fetchTaskCount(){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let sort = NSSortDescriptor(key: "day", ascending: true)
        fetch.sortDescriptors = [sort]
        let result = try? manage?.fetch(fetch) as? [Day]
        
        
    }
    
    func clearData(){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let del = NSBatchDeleteRequest(fetchRequest: fetch)
        do{
            try manage?.execute(del)
            try manage?.save()
        }catch let error{
            print("This is the error fom clearData \(error.localizedDescription)")
        }
    }
}
