//
//  ListViewCell.swift
//  EventScan
//
//  Created by Pratyaksh Motwani on 4/10/19.
//  Copyright © 2019 eventScan. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
