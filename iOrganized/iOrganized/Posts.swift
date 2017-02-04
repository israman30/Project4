//
//  Posts.swift
//  iOrganized
//
//  Created by Israel Manzo on 2/3/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

struct Posts {

    var postImageString: String
    var content: String
    var username: String
    var ref: FIRDatabaseReference?
    var key: String
    
    init(postImageString: String, content: String, username: String, key: String = ""){
        self.postImageString = postImageString
        self.content = content
        self.username = username
        self.key = key
        self.ref = FIRDatabase.database().reference()
        
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        let snapshotValue = snapshot.value as! [String:Any]
        self.postImageString = snapshotValue["postImageString"] as! String
        self.content = snapshotValue["content"] as! String
        self.username = snapshotValue["username"] as! String
        self.ref = snapshot.ref
        
    }
    
    func toAnyObject() -> [String:Any]{
        
        return["postImageString": postImageString, "content":content, "username":username]
        
    }

}
