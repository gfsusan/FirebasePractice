//
//  MyPageTableViewCell.swift
//  FirebasePratice
//
//  Created by CAUCSE on 2018. 4. 30..
//  Copyright © 2018년 mouda. All rights reserved.
//

import UIKit

class MyPageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var thoughtLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
