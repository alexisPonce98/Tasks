//
//  ADDViewController.swift
//  Tasks
//
//  Created by  on 4/8/21.
//  Copyright © 2021 Arizona State University. All rights reserved.
//

import UIKit
import CoreData
class ADDViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    let image = UIImagePickerController()
    var im:Data?
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
   
    
    @IBAction func addImage(_ sender: Any) {
        let aler = UIAlertController(title: "Choose image source", message: "Select to choose an image from your camer or photoLibrary", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Camera", style: .default){ (Action) in
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                self.image.sourceType = .camera
                self.image.allowsEditing = false
                self.image.delegate = self
                self.image.modalPresentationStyle = .popover
                self.present(self.image, animated: true, completion: nil)
                
            }else{
                let alert2 = UIAlertController(title: "You do not have a camera to use silly", message: "Please select PhotLibrary as you do not have a camera", preferredStyle: .alert)
                let action2 = UIAlertAction(title: "OK", style: .default){(action) in
                    
                }
                alert2.addAction(action2)
                self.present(alert2, animated: true, completion: nil)
            }
            }
        let action3 = UIAlertAction(title: "PhotLibrary", style: .default){(action) in
            self.image.sourceType = .photoLibrary
            self.image.delegate = self
            self.image.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.image.modalPresentationStyle = .popover
            self.present(self.image, animated: true, completion: nil)
        }
        aler.addAction(action1)
        aler.addAction(action3)
        self.present(aler, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let images = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.im = images?.pngData() as? Data
        if(self.im == nil){
            print("its nil inside the imagePicker")
        }
        else{
            print("its not nil inside the imagePicker")
        }
         image.dismiss(animated: true, completion: nil)
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "backToToday"){
            let new = segue.destination as? newTableViewController
            print("the value of it from the adds \(new?.fromAdd)")
            new?.fromAdd = true
            print("the value of it from the adds after calling to make it true \(new?.fromAdd)")
            new?.returnTit = self.tit
            new?.returnDesc = self.desc
            new?.returnDest = self.dest
            new?.returnTime = self.time
            if(self.im != nil){
             new?.returnIm = self.im
            }
        }
        else if(segue.identifier == "backToNext"){
            let new = segue.destination as? nextDayTableViewController
            new?.fromAdd = true
            new?.returnTitle = self.tit
            new?.returnDesc = self.desc
            new?.returnDest = self.dest
            new?.returnTime = self.time
            if(self.im != nil){
                new?.returnIm = self.im
            }
            
        }
    }
    

}
