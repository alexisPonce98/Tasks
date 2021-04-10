//
//  nextDayTableViewController.swift
//  Tasks
//
//  Created by  on 4/8/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit

class nextDayTableViewController: UITableViewController {
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
    var fetch = [Day]()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var D:DaysModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        D = DaysModel(context: context!)
        fetch = (D?.fetch())!
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let datComp = self.cal.dateComponents(request, from: date)
        var today = "\(datComp.month), \(datComp.day) \(datComp.year)"
        var count = self.D?.getTasks(day: today)
        return count!.count

    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let datComp = self.cal.dateComponents(request, from: date)
        var today = "\(datComp.month), \(datComp.day) \(datComp.year)"
        var tasks:[Task]
        tasks = (D?.getTasks(day: today))!
        cell.textLabel?.text = tasks[indexPath.row].title!
        return cell
    }
    

   
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
  

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        self.context!.delete(self.fetch[indexPath.row])
        self.fetch.remove(at: indexPath.row)
        do{
            try context!.save()
        }catch let error{
            print("This is the error tha is in editingStyle \(error.localizedDescription)");
        tableView.deleteRows(at: [indexPath], with: .fade)
            }
            } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
