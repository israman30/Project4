//
//  ResetViewController.swift
//  iOrganized
//
//  Created by Israel Manzo on 1/29/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class ResetViewController: UIViewController {

    @IBOutlet weak var resetPasswordTxtField: UITextField!
    
    let networkingServices = NetworkingService()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Reset the password with email. 
    @IBAction func resetPasswordButton(_ sender: Any) {
        
        networkingServices.resetPasswrod(email: resetPasswordTxtField.text!)
        emailResetAlert()
        
        
    }
    
    func emailResetAlert(){
        let alert = UIAlertController(title: "Hello", message: "Instructions had been sent to you on how reset your email. Via email..!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
            print("Ready")
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
            self.present(vc, animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
        
        
    }
    
}
