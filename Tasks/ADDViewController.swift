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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        T = tasksModel(managed: context)
        fetch = T!.fetchResults()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func add(_ sender: Any) {
        var tit:String = ""
        var desc:String = ""
        var time:String = ""
        var dest:String = ""
        if(self.taskTitle.text != nil){
            tit = taskTitle.text!
        }
        if(self.taskDescrip.text != nil){
            desc = taskDescrip.text!
        }
        if(self.taskTime != nil){
            time = taskTime.text!
        }
        if(self.taskDestination.text != nil){
            dest = taskDestination.text!
        }
        
        self.T?.saveContext(tit: tit, desc: desc, dest: dest, time: time)
        fetch = T!.fetchResults()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
