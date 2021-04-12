//
//  ADDViewController.swift
//  Tasks
//
//  Created by  on 4/8/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit
import CoreData
class ADDViewController: UIViewController {

  
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskDescrip: UITextField!
    @IBOutlet weak var taskTime: UITextField!
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var taskDestination: UITextField!
    
    var T:tasksModel?
    var fetch = [Task]()
    var tit:String = ""
    var desc:String = ""
    var time:String = ""
    var dest:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        T = tasksModel(managed: context)
        fetch = T!.fetchResults()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(_ sender: Any) {
        if(self.taskTitle.text != nil){
            self.tit = taskTitle.text!
        }
        if(self.taskDescrip.text != nil){
            self.desc = taskDescrip.text!
        }
        if(self.taskTime != nil){
            self.time = taskTime.text!
        }
        if(self.taskDestination.text != nil){
            self.dest = taskDestination.text!
        }
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "backToday"){
            let new = segue.destination as? newTableViewController
            print("the value of it from the adds \(new?.fromAdd)")
            new?.fromAdd = true
            print("the value of it from the adds after calling to make it true \(new?.fromAdd)")
            new?.returnTit = self.tit
            new?.returnDesc = self.desc
            new?.returnDest = self.dest
            new?.returnTime = self.time
        }
    }
    

}
