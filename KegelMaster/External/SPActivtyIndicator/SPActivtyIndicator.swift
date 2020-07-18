//
//  SPActivtyIndicator.swift
//  Smarty
//
//  Created by Technozer on 4/1/19.
//  Copyright © 2019 Technozer. All rights reserved.
//

import UIKit

class SPActivtyIndicator: UIView {

    //MARK:- Outlet
    @IBOutlet var viewBG: UIView!
    @IBOutlet var ViewImageProgress: UIView!
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet weak var constraintProgressHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintLblTitleWidth: NSLayoutConstraint!
    //MARK:- Variable
    var stMessage: String = ""
    
    override init(frame: CGRect)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.loadXIB()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        //Set Constraint
        //TOP
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0))
        
        //LEADING
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant:0))
        
        //WIDTH
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant:0))
        
        //HEIGHT
        self.addConstraint(NSLayoutConstraint(item: view, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant:0))
        self.lblTitle.text = NSLocalizedString("Please wait while loading", comment: "")
        
        UIApplication.shared.keyWindow?.addSubview(self)
        self.layoutIfNeeded()
        self.backgroundColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.2)
        viewBG.backgroundColor =   UIColor.white//UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8)
      
        if isIpad{
            constraintProgressHeight.constant = 60
            constraintLblTitleWidth.constant = 350
            lblTitle.font = UIFont(name: Font_Arcon_Regular, size: 25)
        }else{
            constraintProgressHeight.constant = 50
            constraintLblTitleWidth.constant = 250
            lblTitle.font = UIFont(name: Font_Arcon_Regular, size: 16)
        }
        
     //   DispatchQueue.main.async {
         //   self.rotateView(targetView: self.ViewImageProgress)
      //  self.rotateImageView()
        self.ViewImageProgress.startRotating()
       // }
        
       
    }
    
//    func rotateView(targetView: UIView, duration: Double = 0.7) {
////       // DispatchQueue.main.async {
////            UIView.animate(withDuration: duration, delay: 0.0, options: [.repeat], animations: {
////                targetView.transform = targetView.transform.rotated(by: CGFloat(-(Double.pi)))
////            }) { finished in
////              //  self.rotateView(targetView: self.ViewImageProgress, duration: -(Double.pi))
////            }
////        //}
//        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: { () -> Void in
//            self.ViewImageProgress.transform = ViewImageProgress.transform.rotated(by: .pi / 2)
//        }) { (finished) -> Void in
//            if finished {
//                self.rotateImageView()
//            }
//        }
//    }
//
    func rotateImageView() {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [UIView.AnimationOptions.curveLinear,UIView.AnimationOptions.repeat], animations: { () -> Void in
            self.ViewImageProgress.transform = self.ViewImageProgress.transform.rotated(by: (.pi) )
        }) { (finished) -> Void in
            if finished {
                self.rotateImageView()
            }
        }
    }
    
    //Mark:- Custom Method
    internal func hideSPActivtyIndicator() {
      self.stopRotating()
    }
}

extension UIView {
    
    func startRotating(duration: CFTimeInterval = 0.8,  clockwise: Bool = true) {
        
        if self.layer.animation(forKey: "transform.rotation.z") != nil {
            return
        }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let direction = clockwise ? 1.0 : -1.0
        animation.toValue = NSNumber(value: .pi * 2 * direction)
        animation.duration = duration
        animation.isCumulative = true
        animation.repeatCount = Float.infinity
        self.layer.add(animation, forKey:"transform.rotation.z")
    }
    
    func stopRotating() {
        
        self.layer.removeAnimation(forKey: "transform.rotation.z")
        
    }
    
}
