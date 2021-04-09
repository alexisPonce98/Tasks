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
    let tableView:UITableView
    var D:DaysModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        D = DaysModel(context: context)
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
       
}

