//
//  newTableViewController.swift
//  Tasks
//
//  Created by  on 4/9/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit

class newTableViewController: UITableViewController {
    
  
    //@IBOutlet var tables: UITableView!
    
    var returnTit:String = ""
    var returnDesc:String = ""
    var returnTime:String = ""
    var returnDest:String = ""
    var returnIm:Data?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fromAdd:Bool = false
    var D:DaysModel?
    var T:tasksModel?
    var fetch = [Day]()
    let date = Date()
    let cal = Calendar.current
    let request: Set<Calendar.Component> = [
    .year,
    .month,
    .day,
    .hour,
    .minute,
    .second
    ]
    var tFetch = [Task]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(customCellTableViewCell.nib(), forCellReuseIdentifier: customCellTableViewCell.identifier)
         let realComp = self.cal.dateComponents(self.request, from: date)
        let today = "\(realComp.month!), \(realComp.day!) \(realComp.year!)"
        D = DaysModel(context: context)
        T = tasksModel(managed: context)
        if((D?.ifToday(today: today))! == false){
            D?.clearData()
            T?.clearData()
        }
        //D?.clearData()
        //T?.clearData()
        tFetch = (T?.fetchResults())!
        fetch = (D?.fetch())!
        for (index,val) in tFetch.enumerated(){
            print(val.title!)
        }
        for (index,val) in fetch.enumerated(){
            print(val.day)
            print("with the value of \(val)")
            print("and ")
            for (index,val) in (val.daysTask?.enumerated())!{
                print("has a task of \(val)")
            }
        }
        
        fetch = (D?.fetch())!
        if(((D?.ifToday(today: today))! == false) ){
            D?.saveDay(day: today)
        }
        if(returnIm == nil){
            print("its nil inside the viewDidLoad of newTable")
        }
        if(fromAdd){
            var task = T?.saveContext(tit: self.returnTit, desc: self.returnDesc, dest: self.returnDest, time: self.returnTime, image: self.returnIm)
            
            D?.saveTaskinDay(task: task, day: today)
            //self.tables.reloadData()
        }
        for (index,val) in fetch.enumerated(){
            print(val.day)
            print("with the value of \(val)")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realComp = self.cal.dateComponents(self.request, from: date)
        let today = "\(realComp.month!), \(realComp.day!) \(realComp.year!)"
        let count = D?.getTasks(day: today)
        
        return count!.count
        
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      //  let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let customCell = tableView.dequeueReusableCell(withIdentifier: customCellTableViewCell.identifier, for: indexPath) as! customCellTableViewCell
          let realComp = self.cal.dateComponents(self.request, from: date)
        var month = 0
        if let x = realComp.month{
            month = x
            print("\(month)")
        }
        var day = 0
        if let x = realComp.day{
            day = x
        }
        var year = 0
        if let x = realComp.year{
            year = x
        }
        let days = "\(month), \(day) \(year)"
        var tasks:[Task]
        tasks = (D?.getTasks(day: days))!
        if(tasks.count != 0){
            var pic = UIImage()
            if(tasks[indexPath.row].image != nil){
                pic = UIImage(data: tasks[indexPath.row].image!)!
            }
            customCell.configure(title: tasks[indexPath.row].title!, image: pic, time: tasks[indexPath.row].time!)
            /*
            cell.textLabel?.text = tasks[indexPath.row].title!
            if(tasks[indexPath.row].image != nil){
            let pic  = UIImage(data: tasks[indexPath.row].image!)
            
            cell.imageView?.image = pic
            }
            */
    }
              return customCell
    }

        // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        self.context.delete(self.fetch[indexPath.row])
        self.fetch.remove(at: indexPath.row)
        do{
            try context.save()
        }catch let error{
            print("This is the error tha is in editingStyle \(error.localizedDescription)");
        tableView.deleteRows(at: [indexPath], with: .fade)
            }
            } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    @IBAction func delete_Task(_ sender: Any) {
        let alert = UIAlertController(title: "You are about to delete all of the days tasks", message: "Would you like to conitinue?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Yes", style: .default){(action) in
            let alert1 = UIAlertController(title: "The deleted tasks would NEVER be able to be recovered", message: "Would you still like to continure", preferredStyle: .alert)
            
            let action1 = UIAlertAction(title: "Yes", style: .default){(action) in// everything will be deleted in                                                                              here
                let realComp = self.cal.dateComponents(self.request, from: self.date)
                let today = "\(realComp.month!), \(realComp.day!) \(realComp.year!)"
                let get_task = self.D?.getTasks(day: today)
                self.D?.delete_tasks(tasks: get_task!, day: today)
                self.fetch = (self.D?.fetch())!
                self.tableView.reloadData()
            }
            let del1 = UIAlertAction(title: "Nevermind", style: .default){(action) in
                
            }
            alert1.addAction(action1)
            alert1.addAction(del1)
            self.present(alert1, animated: true, completion: nil)
        }
        let del = UIAlertAction(title: "Nevermind", style: .default){(action) in
            
        }
        alert.addAction(action)
        alert.addAction(del)
        self.present(alert, animated: true, completion: nil)
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
