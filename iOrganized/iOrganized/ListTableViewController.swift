//
//  ListTableViewController.swift
//  iOrganized
//
//  Created by Israel Manzo on 1/29/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class ListTableViewController: UITableViewController {

    var listArray = [ToDo]()
    
    var databaseRef: FIRDatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Here is checking if user is loged in or go back to log in page
        if FIRAuth.auth()?.currentUser == nil {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            self.present(vc, animated: true, completion: nil)
        
        } else {
        
        databaseRef = FIRDatabase.database().reference().child("allLists")
        
        databaseRef.observe(.value, with: { (snapshot) in
            
            var items = [ToDo]()
            
            for item in snapshot.children {
                let newItem = ToDo(snapshot: item as! FIRDataSnapshot)
                items.insert(newItem, at: 0)
            }
            
            self.listArray = items
            self.tableView.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
        }
    }
    
    //MARK: delegates and data source functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listArray.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListOfTableViewCell
        
        let display = listArray[indexPath.row]
        
        cell.usernameLabel.text = display.username
        cell.titleLabel.text = display.title
        cell.descriptionLabel.text = display.content
        cell.colorView.backgroundColor = UIColor(red: display.red, green: display.green, blue: display.blue , alpha: 1.0)

        return cell
    }
    
    // MARK: Deleting cell: First from data base then from iOS
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let ref = listArray[indexPath.row].ref
            ref!.removeValue()
            listArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "updateInfo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "updateInfo" {
            let vc = segue.destination as! UpdateTableViewController
            let indexPath = tableView.indexPathForSelectedRow!
            vc.todo = listArray[indexPath.row]
        }
    }
    
    
    
    
 
}
