//
//  tasksModel.swift
//  Tasks
//
//  Created by  on 4/8/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import Foundation
import CoreData
class tasksModel{
    var title:String = ""
    var description:String = ""
    var destination:String  = ""
    var time:String = ""
    
    let manage:NSManagedObjectContext

    init(managed:NSManagedObjectContext){
        manage = managed;
    }
    func saveContext(tit:String?, desc:String?, dest:String?, time:String?)->Task{
        let ent = NSEntityDescription.entity(forEntityName: "Task", in: manage)
        let task = Task(entity: ent!, insertInto: manage)
        if(tit != nil){

            self.title = tit!;
            task.title = tit!
        }
        if(desc != nil){
            self.description = desc!;
            task.descrip = desc!
        }
        if(dest != nil){
            self.destination = dest!;
            task.destination = dest!
        }
        if(time != nil){
            self.time = time!;
            task.time = time!
        }
        do{
            print("this is the title: \(task.title) that is being saved in saveContext for taskModel")
            try manage.save()
        }catch let error{
            print(error.localizedDescription.debugDescription)
        }
        return task
    }
    
    func fetchResults()->[Task]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let result = try? manage.fetch(request) as? [Task]
        return result!;
    }
    
    func fetchRecordCount()->Int{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors! = [sort]
        let result = try? manage.fetch(request)
        var count:Int = 0
        if result != nil{
            if(result!.count != nil){
                count = result!.count
            }
            else{
                count = 0;
            }
        }
        return count;
    }
    
    func clearData(){
        let reques = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let del = NSBatchDeleteRequest(fetchRequest: reques)
        do{
            try manage.execute(del)
            try manage.save()
        }catch let error{
            print(error.localizedDescription.debugDescription)
        }
    }
}
