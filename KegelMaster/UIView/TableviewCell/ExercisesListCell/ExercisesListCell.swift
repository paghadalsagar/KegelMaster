//
//  ExercisesListCell.swift
//  KegelMaster
//
//  Created by iMac on 11/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class ExercisesListCell: UITableViewCell {
    
    //MARK:- Outlet
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblExerNote: UILabel!
    @IBOutlet weak var lblRepeter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewBG.layer.shadowColor = UIColor.lightGray.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewBG.layer.shadowOpacity = 0.7
        viewBG.layer.shadowRadius = 1.0
        viewBG.clipsToBounds = false
        viewBG.layer.masksToBounds = true
        
        viewBG.layer.cornerRadius = 10.0
        viewBG.layer.masksToBounds = false
        //        viewBG.backgroundColor = UIColor.yellow
        viewBG.setNeedsLayout()
        viewBG.setNeedsDisplay()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
