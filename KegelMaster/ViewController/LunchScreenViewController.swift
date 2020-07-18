//
//  LunchScreenViewController.swift
//  KegelMaster
//
//  Created by iMac on 16/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class LunchScreenViewController: UIViewController {
    
    @IBOutlet weak var imageviewLogo: UIImageView!
    fileprivate var loaderTimer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.imageviewLogo.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5) // Scale your image
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.imageviewLogo.transform = CGAffineTransform.identity // undo in 1 seconds
                
            })
        }
        
        loaderTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(loaderAction), userInfo: nil, repeats: false)
    }
    
    @objc func loaderAction()
    {
        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "Home_TabBar") as? UITabBarController else { return  }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
}
