//
//  NotesTableViewCell.swift
//  LanscaperQuote
//
//  Created by Aasveen Kaur on 2/7/17.
//  Copyright © 2017 Aasveen. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var notes: UILabel!
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
