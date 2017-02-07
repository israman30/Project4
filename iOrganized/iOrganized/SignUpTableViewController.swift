//
//  SignUpTableViewController.swift
//  iOrganized
//
//  Created by Israel Manzo on 1/29/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class SignUpTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameTxtField: UITextField!
    
    @IBOutlet weak var emailTxtFiel: UITextField!
    
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var locationTxtfield: UITextField!

    var countriesArray = [String]()
    
    var pickerView = UIPickerView()
    
    var networkingServices = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImageView.backgroundColor = .clear
        userImageView.layer.cornerRadius = 92.5
        userImageView.layer.borderWidth = 1
        
        
        //MARK: Location: This loop will get the countries from Locale apple property
        for code in Locale.isoRegionCodes {
            let country = Locale.current.localizedString(forRegionCode: code)!
            print(code)
            let name = Locale(identifier: "en_EN").localizedString(forCollationIdentifier: country) ?? "\(country)"
            print("Found countries \(country)")
            countriesArray.append(name)
            countriesArray.sort(by: { (name1, name2) -> Bool in
                name1 < name2
            })
        }
    
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor.black
        locationTxtfield.inputView = pickerView
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector( SignUpTableViewController.dismissController(gesture:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // dismiss view controller after picker get call
    func dismissController(gesture: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    // Dismiss keyboar when touches ousides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: Delegates and data source Picker controller functions
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countriesArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationTxtfield.text = countriesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countriesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title = NSAttributedString(string: countriesArray[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
        return title
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // MARK: Action Button that allows to use camera, photo library, save and cancel 
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
    
// MARK: This function pick the image from the photo library as String and pass it to UIImage vie in the iOS
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            userImageView.image = image
        } else {
            print("Image was not selected")
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: Action - sign up a new user
    @IBAction func signUpButton(_ sender: Any) {
        
        let data = UIImageJPEGRepresentation(userImageView.image!, 0.8)
        
        networkingServices.signUp(email: emailTxtFiel.text!,
                                  username: userNameTxtField.text!,
                                  password: passwordTxtField.text!,
                                  location: locationTxtfield.text!,
                                  data: data!)
    }
    
}




