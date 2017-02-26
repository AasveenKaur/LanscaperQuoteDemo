//
//  SubTotalTableViewCell.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/7/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class SubTotalTableViewCell: UITableViewCell {
    @IBOutlet weak var subTotalValue: UILabel!

    @IBOutlet weak var discountValue: UILabel!
    
    
    @IBOutlet weak var taxValue: UILabel!
    
    @IBOutlet weak var totalValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
