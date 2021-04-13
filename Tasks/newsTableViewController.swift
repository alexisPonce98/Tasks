//
//  newsTableViewController.swift
//  Tasks
//
//  Created by  on 4/8/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit

class newsTableViewController: UITableViewController {
    struct news:Decodable {
        let articles:[Article]
    }
    struct Article:Decodable{
        let Author:String?
        let description:String?
        let publishedAt:String?
        let title:String?
        let url:URL?
        let urlToImage:URL?
    }
    var newsItems:[Article]?
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async(execute: {
            self.getNews()
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    func getNews(){
        let urlAsString = "https://newsapi.org/v2/everything?q=UnitedStates&apikey=839d14ef595f416a81b445ab621a409c"
        let url = URL(string: urlAsString)
        let urlSession = URLSession.shared
        
        let jsonQuery = urlSession.dataTask(with: url!){ (data, response, error) in
            if(error != nil){
                print("got an error whith jsonQuery \(error!.localizedDescription)")
            }
            var err:NSError
            
            let decoder = JSONDecoder()
            let jsonResult = try! decoder.decode(news.self, from: data!)
            self.newsItems = jsonResult.articles
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        jsonQuery.resume()
        
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = self.newsItems?.count{
            return count
        }else{
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        cell.layer.borderWidth = 1.0
        cell.textLabel?.text = newsItems![indexPath.row].description
        if let x = newsItems![indexPath.row].Author{
            cell.detailTextLabel?.text = x
        }else{
            cell.detailTextLabel?.text = "No Author"
        }
       // if let x = newsItems![indexPath.row].urlToImage{
            //DispatchQueue.global().async {
                if let x = self.newsItems![indexPath.row].urlToImage{
                    //DispatchQueue.main.async {
                        let data = try? Data(contentsOf: x)
                        cell.imageView?.image = UIImage(data: data!)
                    //}
                }
            //}
            
       // }
        
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
