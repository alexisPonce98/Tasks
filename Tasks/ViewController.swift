//
//  ViewController.swift
//  Tasks
//
//  Created by  on 3/21/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit
import CoreData;
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
     
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var D:DaysModel?
    var fetch = [Day]()
    override func viewDidLoad() {
        super.viewDidLoad()
        D = DaysModel(context: context)
        fetch = (D?.fetch())!
          print("i am in viewController")
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = D?.fetchRecordCount()
        return count!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        var date:String = ""
        var tasks:[Task]
        tasks = (D?.getTasks(day: date))!
        cell.textLabel?.text = tasks[indexPath.row].title!
          print("\(tasks[indexPath.row].title) is the title at \(indexPath.row)")
        return cell
        
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            self.context.delete(self.fetch[indexPath.row])
            self.fetch.remove(at: indexPath.row)
            do{
                try context.save()
            }catch let error{
                print("This is the error tha is in editingStyle \(error.localizedDescription)")
            }
        }
    }
       
}

