//
//  optionCell.swift
//  victorinaDrink
//
//  Created by Павел Губарев on 06/12/2017.
//  Copyright © 2017 Pavel Gubarev. All rights reserved.
//

import UIKit

class optionCell: UITableViewCell {

    @IBOutlet weak var optionLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        self.selectedBackgroundView?.frame = CGRect(x: 0, y: 10, width: self.frame.size.width, height: self.frame.size.height - 10)
    }
    
   
}
