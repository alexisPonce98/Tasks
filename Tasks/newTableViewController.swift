//
//  newTableViewController.swift
//  Tasks
//
//  Created by  on 4/9/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit

class newTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var D:DaysModel?
    var fetch = [Day]()
    override func viewDidLoad() {
        super.viewDidLoad()
        D = DaysModel(context: context)
        fetch = (D?.fetch())!
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       let count = D?.fetchRecordCount()
        return count!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = D?.fetchRecordCount()
        return count!
        
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
          var date:String = ""
              var tasks:[Task]
              tasks = (D?.getTasks(day: date))!
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