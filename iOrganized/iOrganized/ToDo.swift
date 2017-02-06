//
//  ToDo.swift
//  iOrganized
//
//  Created by Israel Manzo on 2/2/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct ToDo {

    var title: String
    var content: String
    var username: String
    var red: CGFloat
    var blue: CGFloat
    var green: CGFloat
    var ref: FIRDatabaseReference?
    var key: String
    
    init(title: String, content: String, username: String, red: CGFloat, blue: CGFloat, green: CGFloat, key: String = ""){
        self.title = title
        self.content = content
        self.username = username
        self.red = red
        self.blue = blue
        self.green = green
        self.key = key
        self.ref = FIRDatabase.database().reference()
    
    }
    
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        let snapshotValue = snapshot.value as! [String:Any]
        self.title = snapshotValue["title"] as! String
        self.content = snapshotValue["content"] as! String
        self.username = snapshotValue["username"] as! String
        self.red = snapshotValue["red"] as! CGFloat
        self.blue = snapshotValue["blue"] as! CGFloat
        self.green = snapshotValue["green"] as! CGFloat
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String:Any]{
    
        return["title": title,
               "content":content,
               "username":username,
               "blue":blue,
               "red":red,
               "green":green
        ]
    }
}
