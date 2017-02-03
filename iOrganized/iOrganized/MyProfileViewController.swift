//
//  MyProfileViewController.swift
//  iOrganized
//
//  Created by Israel Manzo on 2/2/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var userPhotoImage: UIImageView!
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var location: UITextField!

    @IBOutlet weak var email: UITextField!
    
    var urlImage: String!
    
    var databaseRef: FIRDatabaseReference!{
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FIRAuth.auth()?.currentUser == nil {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            present(vc, animated: true, completion: nil)
        
        } else {
        
        databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observe( .value, with: { (snapshot) in
            DispatchQueue.main.async {
                let user = User(snapshot: snapshot)
                self.username.text = user.username
                self.email.text = user.email
                self.location.text = user.location
                let imageUrl = String(user.photoUrl)
                
                self.storageRef.reference(forURL: imageUrl!).data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
                    
                    if let error = error {
                        
                        print(error.localizedDescription)
                    
                    } else {
                        if let data = data {
                            
                            self.userPhotoImage.image = UIImage(data: data)
                        
                        }
                    }
                })
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }

       }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        if FIRAuth.auth()?.currentUser != nil {
            
            do {
                
                try FIRAuth.auth()?.signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
            
            } catch let error {
                print(error.localizedDescription)
            }
        
        }
    }
}
