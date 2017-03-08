//
//  InvoiceTableViewCell.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/25/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class InvoiceTableViewCell: UITableViewCell {
    @IBOutlet weak var invoiceNumber: UILabel!

    @IBOutlet weak var invoiceTotal: UILabel!
    @IBOutlet weak var clientName: UILabel!
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
