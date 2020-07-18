//
//  ReminderListCell.swift
//  KegelMaster
//
//  Created by iMac on 13/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class ReminderListCell: UITableViewCell {

    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnRemove: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
