//
//  ViewController.swift
//  iOrganized
//
//  Created by Israel Manzo on 1/29/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    let networkingServices = NetworkingService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToLogin(storyboard: UIStoryboardSegue){}

    @IBAction func logInButton(_ sender: Any) {
        
        networkingServices.signIn(email: username.text!, password: password.text!, complete: { success in
            if success {
                DispatchQueue.main.async {
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
                    self.present(vc, animated: true, completion: nil)
                }
            }
        })
    }
}

