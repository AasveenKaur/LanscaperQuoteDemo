//
//  QuoteTableViewCell.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/8/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class QuoteTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var quoteNumber: UILabel!
    
    
    @IBOutlet weak var clientName: UILabel!
    
    @IBOutlet weak var quoteTotal: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
