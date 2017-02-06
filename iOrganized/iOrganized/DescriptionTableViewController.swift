//
//  DescriptionTableViewController.swift
//  iOrganized
//
//  Created by Israel Manzo on 1/29/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class DescriptionTableViewController: UITableViewController {
    
    @IBOutlet weak var itemNameTxtField: UITextField!

    @IBOutlet weak var descriptionTxtField: UITextView!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    // MARK: This action will save each descrition list
    @IBAction func save(_ sender: Any) {
        
        let todoRef = databaseRef.child("allLists").childByAutoId()
        
        let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
        let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
        let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
        
        var title = String()
        if itemNameTxtField.text == "" {
            itemNameTxtField.text = "No item name"
            title = itemNameTxtField.text!
        } else {
            title = itemNameTxtField.text!
        }
        
        var content = String()
        if descriptionTxtField.text == "" {
            descriptionTxtField.text = "No description"
            content = descriptionTxtField.text
        } else {
            content = descriptionTxtField.text
        }
        
        let todo = ToDo(title: title, content: content, username: FIRAuth.auth()!.currentUser!.displayName!, red: red, blue: blue, green: green)
        todoRef.setValue(todo.toAnyObject())
        
        self.navigationController!.popToRootViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

   }
