//
//  LineItemTableViewCell.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/7/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class LineItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lineItem: UILabel!
    
    @IBOutlet weak var lineItemTotal: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
