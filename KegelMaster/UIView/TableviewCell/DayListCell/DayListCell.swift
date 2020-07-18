//
//  DayListCell.swift
//  KegelMaster
//
//  Created by iMac on 09/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit
import CircleProgressBar
class DayListCell: UITableViewCell {

    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewProgress: CircleProgressBar!
    @IBOutlet weak var imageviewClock: UIImageView!
    @IBOutlet weak var imageRightArrow: UIImageView!
    @IBOutlet weak var lblDayName: UILabel!
    @IBOutlet weak var lblExerciseTime: UILabel!
    @IBOutlet weak var imageviewRightArrow: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewBG.layer.shadowColor = UIColor.lightGray.cgColor
        viewBG.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewBG.layer.shadowOpacity = 0.7
        viewBG.layer.shadowRadius = 1.0
        viewBG.clipsToBounds = false
        viewBG.layer.masksToBounds = true
        
        viewBG.layer.cornerRadius = 5.0
        viewBG.layer.masksToBounds = false
        //        viewBG.backgroundColor = UIColor.yellow
        viewBG.setNeedsLayout()
        viewBG.setNeedsDisplay()
        self.selectionStyle = .none
        viewProgress.hintTextFont = UIFont.boldSystemFont(ofSize: 13.0)
        
    }

    func setProgressAndColor(color: UIColor,progress:CGFloat){
        viewProgress.setProgress(progress, animated: true, duration: 0.3)
        viewProgress.hintTextColor = color
        viewProgress.progressBarProgressColor = color
        
        imageviewClock.image = imageviewClock.image?.withRenderingMode(.alwaysTemplate)
        imageviewClock.tintColor = color
        
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
