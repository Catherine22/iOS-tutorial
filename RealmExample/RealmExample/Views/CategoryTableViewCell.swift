//
//  CategoryTableViewCell.swift
//  RealmExample
//
//  Created by Catherine Chen (RD-TW) on 29/01/2019.
//  Copyright © 2019 Catherine Chen. All rights reserved.
//

import UIKit
import SwipeCellKit

class CategoryTableViewCell: SwipeTableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
