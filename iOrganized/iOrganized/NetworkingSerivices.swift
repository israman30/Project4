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

    var dataBaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    // MARK: 3.- Saving user info in database
    private func saveInfo(user: FIRUser! , username: String, password:String, location: String){
        
        let userInfo = ["email":user.email,
                        "username": username,
                        "location":location,
                        "uid":user.uid,
                        "photoUrl":String(describing: user.photoURL!)
        ]
        
        let userRef = dataBaseRef.child("users").child(user.uid)
        userRef.setValue(userInfo)
    
        //siging in the user and saving info
        signIn(email: user.email!, password: password, complete: {_ in})
    }
    
    //MARK: 4.- sign in the user
    func signIn(email: String, password: String, complete: @escaping (Bool)->() ){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    print("\(user.displayName!) has signed in succesfully!")
                    complete(true)
                }
            } else {
                print(error!.localizedDescription)
                complete(false)
            }
        })
    }
    
    // MARK: 2.- set user info
    private func setUserInfo(user: FIRUser!, username: String, password:String, location: String, data: Data!){
        
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        let metaData = FIRStorageMetadata()
        
        metaData.contentType = "image/jpg"
        
        imageRef.put(data, metadata: metaData) { (metaData, error) in
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = username
                changeRequest.photoURL = metaData!.downloadURL()
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
    
    // MARK: 1.- create a user
    func signUp(email: String ,username: String, password:String, location: String, data: Data!){
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                
                self.setUserInfo(user: user!, username: username, password: password, location: location, data: data)
            
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    
    //MARK: reset password
    func resetPasswrod(email: String){
        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email, completion: { (error) in
            if error == nil {
                
                print("An email to explain how to reset password has been sent to you. Thank you!")
                
            } else {
                
                print(error!.localizedDescription)
            
            }
        })
    }
    
    
    
}
