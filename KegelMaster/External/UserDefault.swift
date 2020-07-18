//
//  UserDefault.swift



let UD_APP_SELECTED_Vibration                              = "UD_APP_SELECTED_Vibration"
let UD_APP_SELECTED_Language                               = "UD_APP_SELECTED_Language"
let UD_APP_IS_INTERNET                                     = "UD_APP_IS_INTERNET"
let UD_IS_PURCHASE                          = "UD_IS_PURCHASE"

import UIKit

class UserDefault: NSObject {
    
    class func setIsVibration(_ isVibration: Bool) {
        UserDefaults.standard.setValue(isVibration, forKey:UD_APP_SELECTED_Vibration)
        UserDefaults.standard.synchronize()
    }
    
    class func getIsVibration() -> Bool {
        var isVibration: Bool = true
        if UserDefaults.standard.value(forKey: UD_APP_SELECTED_Vibration) != nil {
            isVibration = (UserDefaults.standard.value(forKey: UD_APP_SELECTED_Vibration) as! Bool)
        }
        return isVibration
    }
    
    class func setSelectedLanguage(_ stLanguage: String) {
        UserDefaults.standard.setValue(stLanguage, forKey:UD_APP_SELECTED_Language)
        UserDefaults.standard.synchronize()
    }
    
    class func geSelectedLanguage() -> String {
        var stLanguage: String = "1"
        if UserDefaults.standard.value(forKey: UD_APP_SELECTED_Language) != nil {
            stLanguage = (UserDefaults.standard.value(forKey: UD_APP_SELECTED_Language) as! String)
        }
        return stLanguage
    }
    
    class func setIsINTERNET(_ isInterNet: Bool) {
        UserDefaults.standard.setValue(isInterNet, forKey:UD_APP_IS_INTERNET)
        UserDefaults.standard.synchronize()
    }
    
    class func getIsINTERNET() -> Bool {
        var isInterNet: Bool = false
        if UserDefaults.standard.value(forKey: UD_APP_IS_INTERNET) != nil {
            isInterNet = (UserDefaults.standard.value(forKey: UD_APP_IS_INTERNET) as! Bool)
        }
        return isInterNet
    }
    
    class func setIsPurchase(_ isPurchase: Bool) {
          UserDefaults.standard.setValue(isPurchase, forKey:UD_IS_PURCHASE)
          UserDefaults.standard.synchronize()
      }
      
      class func getIsPurchase() -> Bool {
          var isPurchase: Bool = false
          if UserDefaults.standard.value(forKey: UD_IS_PURCHASE) != nil {
              isPurchase = (UserDefaults.standard.value(forKey: UD_IS_PURCHASE) as! Bool)
          }
          return isPurchase
      }
}
