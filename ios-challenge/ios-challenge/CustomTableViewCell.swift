//
//  CustomTableViewCell.swift
//  ios-challenge
//
//  Created by Ali Hamdi on 01/05/2018.
//  Copyright © 2018 Ali Hamdi. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var articaleImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
