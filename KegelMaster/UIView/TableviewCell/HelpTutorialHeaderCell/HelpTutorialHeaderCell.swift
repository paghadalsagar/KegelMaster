//
//  HelpTutorialHeaderCell.swift
//  KegelMaster
//
//  Created by iMac on 12/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class HelpTutorialHeaderCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imageviewArrow: UIImageView!
    @IBOutlet weak var btnCellAction: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
           super.layoutSubviews()
           //set the values for top,left,bottom,right margins
           let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
           contentView.frame = contentView.frame.inset(by: margins)
       }
}
