//
//  PersonTableViewCell.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 18/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
