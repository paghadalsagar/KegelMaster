//
//  SPToastView.swift

//  Copyright © 2019 Technozer. All rights reserved.
//

import UIKit

class SPToastView: UIView {
    
    
    //MARK:- PROPERTY
    @IBOutlet var viewBG: UIView!
    @IBOutlet var lblMessage: UILabel!
    @IBOutlet var constraintViewBGBottom: NSLayoutConstraint!
    @IBOutlet var imageViewAlert: UIImageView!
    
    //MARK:- Variable
    let obj_AppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var stMessage: String = ""
    var _errorCode: Int = 0
    
    override init(frame: CGRect)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.loadXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    required init(_ message: String, errorCode: Int)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        stMessage = message;
        _errorCode = errorCode
        self.loadXIB()
    }
    
    required init(_ message: String)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        stMessage = message;
        self.loadXIB()
    }
    
    //MARK:- loadXIB Function
    fileprivate func loadXIB() {
        //Get XIB
        let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(view)
        self.alpha = 1;
        self.isUserInteractionEnabled = false
        //Set Constraint
        //TOP
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0))
        
        //LEADING
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant:0))
        
        //WIDTH
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant:0))
        
        //HEIGHT
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant:0))
        
        UIApplication.shared.keyWindow?.addSubview(self)
        lblMessage.text = NSLocalizedString(stMessage, comment: "");
        //        if isIpad{
        //            lblMessage.font = UIFont(name: Font_Arcon_Regular, size: 24)
        //        }else{
        //            lblMessage.font = UIFont(name: Font_Arcon_Regular, size: 17)
        //        }
        //
        switch _errorCode {
        case 0:
            //toast_failed
            viewBG.backgroundColor = UIColor.black
            lblMessage.textColor = UIColor.white
            //imageViewAlert.image = UIImage(named: "icn_toast_close")
            break
        case 1:
            //toast_success
            viewBG.backgroundColor = UIColor.black
            lblMessage.textColor = UIColor.white
            //imageViewAlert.image = UIImage(named: "ic_toast_true")
            break
        case 201:
            //toast_warning
            viewBG.backgroundColor = UIColor.black
            lblMessage.textColor = UIColor.white
            //imageViewAlert.image = UIImage(named: "icn_toast_warning")
            break
        case 202:
            //toast_info
            viewBG.backgroundColor = UIColor.black
            lblMessage.textColor = UIColor.white
            //imageViewAlert.image = UIImage(named: "ic_toast_info")
            break
        default:
            lblMessage.textColor = UIColor.black
            viewBG.backgroundColor = UIColor.white
            
            break
        }
        
        self.layoutIfNeeded()
        constraintViewBGBottom.constant = -(viewBG.frame.height + 50);
        self.layoutIfNeeded()
        
        constraintViewBGBottom.constant = 20;
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: { self.layoutIfNeeded() }) { (finished) in self.perform(#selector(self.hideSPToast), with: nil, afterDelay: 1.4) }
    }
    
    //Mark:- Custom Method
    @objc internal func hideSPToast() {
        constraintViewBGBottom.constant = -(viewBG.frame.height + 50);
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: { self.layoutIfNeeded() }) { (finished) in self.removeFromSuperview() }
    }
    
}
