 //
//  ListOfTableViewCell.swift
//  iOrganized
//
//  Created by Israel Manzo on 2/3/17.
//  Copyright © 2017 Israel Manzo. All rights reserved.
//

import UIKit

class ListOfTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorView.layer.cornerRadius = 10
    }
}
