//
//  NetworkingSerivices.swift
//  iOrganized
//
//  Created by Israel Manzo on 1/30/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct NetworkingService {

    let dataBaseRef = FIRDatabase.database().reference()
    let storageRef = FIRStorage.storage().reference()
    
    private func saveInfo(user: FIRUser, username: String, password:String, location: String){
        let userInfo = ["email":user.email, "username": username, "location":location, "uid":user.uid, "photoUrl":String(describing: user.photoURL!)]
        
        let userRef = dataBaseRef.child("users").child(user.uid)
        userRef.setValue(userInfo)
    
        //siging in the user and saving info
        signIn(email: user.email!, password: password)
    }
    
    //sign in user
    func signIn(email: String, password: String){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    print("\(user.displayName) has signed in succesfully!")
                }
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    // This function create a new user
    private func setUserInfo(user: FIRUser, username: String, password:String, location: String, data: NSData!){
        
        let imagePath = "profilImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        let metaData = FIRStorageMetadata()
        
        metaData .contentType = "image/jpg"
        
        imageRef.put(data as Data, metadata: metaData) { (metaData, error) in
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL =  metaData?.downloadURL()
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        self.saveInfo(user: user, username: username , password: password, location: location)
                    } else {
                        print(error!.localizedDescription)
                    }
                })
            
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
