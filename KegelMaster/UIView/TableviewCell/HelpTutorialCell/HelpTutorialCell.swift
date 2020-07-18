//
//  HelpTutorialCell.swift
//  KegelMaster
//
//  Created by iMac on 12/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class HelpTutorialCell: UITableViewCell {

    @IBOutlet weak var lblHelpDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}
