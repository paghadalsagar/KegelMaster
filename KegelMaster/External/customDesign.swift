//
//  customDesign.swift
//
//  Created by Sagar Paghadal on 5/11/19.
//

import UIKit

let NOTIFICATION_GET_DEVICE_TOKEN                   = "NOTIFICATION_GET_DEVICE_TOKEN"

let themeColor: UIColor                             = UIColor.init(red: 78/255, green: 206/255, blue: 219/255, alpha: 1) //4ECEDB
let lightBlack: UIColor                             = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
let lightGray: UIColor                              = UIColor.init(red: 130/255, green: 130/255, blue: 130/255, alpha: 0.8)
let darkGray: UIColor                               = UIColor.init(red: 54/255, green: 54/255, blue: 54/255, alpha: 0.8)


//FontName
let  Font_Arcon_Regular                            = "Arcon-Regular"
let  Font_Mytupi_Bold                              = "Mytupi-Bold"

let HEIGHT_NATIVE_AD:CGFloat                       = 280.0

let HEIGHT_NOTICE_LIST: CGFloat                     = 150.0
let HEIGHT_COLLECTION_LIST: CGFloat                 = 137.5
let HEIGHT_MANAGER_COLLECTION_LIST: CGFloat         = 180.0
let HEIGHT_ASSESTS_LIST: CGFloat                    = 50.0
let HEIGHT_TRANDACTION_LIST: CGFloat                = 80.0
let HEIGHT_MORE_DETAILS_LIST: CGFloat               = 30.0
let HEIGHT_COLLECTION_MEMBERS_LIST: CGFloat         = 60.0

class customDesign: NSObject {
    //MARK: VARIABLE
    var _SPActivtyIndicator: SPActivtyIndicator?
    
    static let sharedInstance = customDesign()
    
    // Mark: Activity Indicator
    class func startActivityIndicator(_ view: UIView) {
        sharedInstance._SPActivtyIndicator?.removeFromSuperview()
        self.startActivityIndicator(view, title: NSLocalizedString("Loading...", comment: ""))
    }
    
    class func startActivityIndicator(_ view: UIView, title: String) {
        sharedInstance._SPActivtyIndicator = SPActivtyIndicator.init(title)
        view.addSubview(sharedInstance._SPActivtyIndicator!)
    }
    
    class func stopActivityIndicator() {
        DispatchQueue.main.async {
            sharedInstance._SPActivtyIndicator?.hideSPActivtyIndicator()
            sharedInstance._SPActivtyIndicator?.removeFromSuperview()
        }
     }
    
    
    
  
    
    class func setConstraint_ConWidth_ConHeight_Leading_Top(_ subView: UIView, superView: UIView, width: CGFloat, height: CGFloat , top:CGFloat , leading:CGFloat) -> [String:AnyObject] {
        subView.translatesAutoresizingMaskIntoConstraints  = false;
        
        //WIDTH -  CONSTATNT
        let constraintWidth: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: width)
        superView.addConstraint(constraintWidth)
        
        //HEIGHT -  CONSTATNT
        let constraintHeight: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: height)
        superView.addConstraint(constraintHeight)
        
        //LEADING
        let constraintLeading: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: leading)
        superView.addConstraint(constraintLeading)
        
        //TOP
        let constraintTop: NSLayoutConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: superView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: top)
        superView.addConstraint(constraintTop)
        
        superView.layoutIfNeeded()
        
        return ["CONSTRAINT_WIDTH":constraintWidth,"CONSTRAINT_HEIGHT":constraintHeight,"CONSTRAINT_LEADING":constraintLeading,"CONSTRAINT_TOP":constraintTop]
    }

    

    
}
