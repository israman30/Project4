//
//  User.swift
//  iOrganized
//
//  Created by Israel Manzo on 2/2/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct User {

    var username:String
    var email:String
    var photoUrl: String
    var location: String
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        username = snapshot.value as! String
        email = snapshot.value as! String
        photoUrl = snapshot.value as! String
        location = snapshot.value as! String
        ref = snapshot.ref
    }
    
}
