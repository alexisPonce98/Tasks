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
        
       
        do{
            print("\(dayy.day) has been saved")
            try manage?.save()
        }catch let error{
            print("This is the erro in single day save \(error.localizedDescription)")
        }
    }
    
    func ifToday(today:String)->Bool{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let sort = NSSortDescriptor.init(key: "day", ascending: true)
        fetch.sortDescriptors = [sort]
        let result = try? manage?.fetch(fetch) as? [Day]
        var ret = false
        for (_,val) in (result!.enumerated()){
            if(val.day == today){
                ret = true
            }
        }
        return ret
    }
    
    func saveTaskinDay(task:Task?, day:String?){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let sort = NSSortDescriptor.init(key: "day", ascending: true)
        fetch.sortDescriptors = [sort]
        let result = try? manage?.fetch(fetch) as? [Day]
        for (index,val) in (result?.enumerated())!{
            if(val.day == day){
                if task != nil{
                    val.addToDaysTask(task!)
                }
            }
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
        let sort = NSSortDescriptor.init(key: "day", ascending: true)
        fetchd.sortDescriptors = [sort]
        let result = try? manage?.fetch(fetchd) as? [Day]
        let count = result!.count
        return count
        
    }
    
    func fetchTaskCount(tasks:Task, day:String)->Int{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let sort = NSSortDescriptor(key: "day", ascending: true)
        fetch.sortDescriptors = [sort]
        let result = try? manage?.fetch(fetch) as? [Day]
        var count:Int = 0
        for (index,val) in (result?.enumerated())!{
            if(val.day == day){
                count = val.daysTask!.count
            }
        }
        
        return count
    }
    
    func getTasks(day:String?)->[Task]{
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Day")
        let sort = NSSortDescriptor.init(key: "day", ascending: true)
        fetch.sortDescriptors = [sort]
        var today:String = ""
        if let x = day{
            today = x
        }
        let result = try? manage?.fetch(fetch) as? [Day]
        var ret = [Task]()
        for (index,val) in result!.enumerated(){
            print("I am inside for loop for getTasks \(val.day!) is being compared with \(today)")
            if(val.day! == today){
                print("maybe it worked")
                ret = (val.daysTask?.allObjects as? [Task])!
            }
        }
        return ret
        
        
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
