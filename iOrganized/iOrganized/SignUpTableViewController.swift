//
//  SignUpTableViewController.swift
//  iOrganized
//
//  Created by Israel Manzo on 1/29/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var emailTxtFiel: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var locationTxtfield: UITextField!

//    var countriesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        for code in NSLocale.isoCountryCodes as [String] {
//            let id = NSLocale.localeIdentifier(fromComponents: <#T##[String : String]#>)
////            let id = NSLocale.localeIdentifier(fromComponents: [CFLocaleIdentifier:code])
//            
//        }
    }

    @IBAction func choosePic(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Photo", message: "Choose from", preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {action in
            pickerController.sourceType = .camera
            
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let photoAlbumAction = UIAlertAction(title: "Photo Library", style: .default) {action in
            pickerController.sourceType = .photoLibrary
            
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let savePhotoAction = UIAlertAction(title: "Saved Photo", style: .default) {action in
            pickerController.sourceType = .savedPhotosAlbum
            
            self.present(pickerController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photoAlbumAction)
        alertController.addAction(savePhotoAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickercontroller(picker: UIImagePickerController, didFinishPickingImage image: UIImage,editingInfo: [String:AnyObject]?) {
        self.dismiss(animated: true, completion: nil)
        self.userImageView.image = image
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
    
}
