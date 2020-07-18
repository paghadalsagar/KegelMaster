//
//  AppDelegate.swift
//  KegelMaster
//
//  Created by iMac on 07/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//
//com.kegel.training.exercises

import UIKit
import Appodeal
import StackConsentManager
import StoreKit
import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private struct AppodealConstants {
        static let key: String = ADV_ID//"dee74c5129f53fc629a44a690a02296694e3eef99f2d3a5f"  //"cecc519de02eaa6216384ba507b1f656ee4d60851c15e4c8"
        static let adTypes: AppodealAdType = [.interstitial, .rewardedVideo, .banner, .nativeAd]
        static let logLevel: APDLogLevel = .error
        static let testMode: Bool = true
    }
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        notificationCenter.delegate = self
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) {
            (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        self.synchroniseConsent()
        self.copyDBInApp()
        self.setupLanguage()
        self.checkProductPurchse()
        SSASwiftReachability.sharedManager?.startMonitoring()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityStatusChanged(notification:)), name: NSNotification.Name(rawValue: SSAReachabilityDidChangeNotification), object: nil)
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    // MARK: Appodeal Initialization
    private func initializeAppodealSDK() {
        Appodeal.setTestingEnabled(AppodealConstants.testMode)
        //        Appodeal.setLogLevel(AppodealConstants.logLevel)
        Appodeal.setAutocache(true, types: AppodealConstants.adTypes)
        
        let consent = STKConsentManager.shared().consentStatus != .nonPersonalized
        Appodeal.initialize(
            withApiKey: AppodealConstants.key,
            types: AppodealConstants.adTypes,
            hasConsent: consent
        )
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "nativeAdvLoad"), object: nil, userInfo: nil)
    }
    
    // MARK: Consent manager
    private func synchroniseConsent() {
        STKConsentManager.shared().synchronize(withAppKey: AppodealConstants.key) { error in
            error.map { print("Error while synchronising consent manager: \($0)") }
            guard STKConsentManager.shared().shouldShowConsentDialog == .true else {
                self.initializeAppodealSDK()
                return
            }
            
            STKConsentManager.shared().loadConsentDialog { [unowned self] error in
                error.map { print("Error while loading consent dialog: \($0)") }
                guard let controller = self.window?.rootViewController, STKConsentManager.shared().isConsentDialogReady else {
                    self.initializeAppodealSDK()
                    return
                }
                
                STKConsentManager.shared().showConsentDialog(fromRootViewController: controller,
                                                             delegate: self)
            }
        }
    }
    
    
    func reStartApp(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LunchScreenViewController")
        self.window?.rootViewController = vc
    }
    
    
    //MARK:- Copy Data Base
    func copyDBInApp() {
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path1 = path[0]
        let fullpath = path1.appending("/\(DB_Name).db")
        let fmg = FileManager()
        if !fmg.fileExists(atPath: fullpath)
        {
            let localpath = Bundle.main.path(forResource: "\(DB_Name)", ofType: "db")
            do {
                try  fmg.copyItem(atPath: localpath!, toPath: fullpath)
            } catch  {
                print("Not")
            }
            
        }
    }
    
    func setupLanguage(){
        if "1" == UserDefault.geSelectedLanguage(){
            PPLocalization.sharedInstance.setLanguage(language: "en")
        }else if "2" == UserDefault.geSelectedLanguage(){
            PPLocalization.sharedInstance.setLanguage(language: "ru")
        }else if "3" == UserDefault.geSelectedLanguage(){
            PPLocalization.sharedInstance.setLanguage(language: "es")
        }else if "4" == UserDefault.geSelectedLanguage(){
            PPLocalization.sharedInstance.setLanguage(language: "de")
        }else if "5" == UserDefault.geSelectedLanguage(){
            PPLocalization.sharedInstance.setLanguage(language: "fr")
        }else if "6" == UserDefault.geSelectedLanguage(){
            PPLocalization.sharedInstance.setLanguage(language: "pt-PT")
        }else if "7" == UserDefault.geSelectedLanguage(){
            PPLocalization.sharedInstance.setLanguage(language: "ja")
        }
    }
    
    
    @objc func reachabilityStatusChanged(notification: NSNotification) {
        if let info = notification.userInfo {
            if let reachability = info[SSAReachabilityNotificationStatusItem] {
                if "reachable" == "\(reachability)"{
                    print("Internet access")
                    UserDefault.setIsINTERNET(true)
                }else{
                    print("no Internet access")
                    UserDefault.setIsINTERNET(false)
                }
            }
        }
    }
    
    
    func checkProductPurchse() {
        DispatchQueue.global().async(execute: {
            let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: "d9d3a8c9305a41aabadb4d141affd6dd")
            SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
                customDesign.stopActivityIndicator()
                
                switch result {
                case .success(let receipt):
                    guard let identifier = productIdentifiers as? Set<String> else { return }
                    let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: identifier, inReceipt: receipt)
                    DispatchQueue.main.async{
                        switch purchaseResult {
                        case .purchased(_):
                            //  let _ = SPToastView.init("\(productId) is valid until")
                            UserDefault.setIsPurchase(true)
                            break
                        case .expired( _):
                            //let _ = SPToastView.init("\(productId) is expired")
                            UserDefault.setIsPurchase(false)
                            break
                        case .notPurchased:
                            // print("The user has never purchased \(productId)")
                            UserDefault.setIsPurchase(false)
                            break
                        }
                    }
                case .error(let error):
                      UserDefault.setIsPurchase(false)
                    print("Receipt verification failed: \(error)")
                }
                
            }
        })
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        completionHandler()
    }
}

extension AppDelegate: STKConsentManagerDisplayDelegate {
    func consentManagerWillShowDialog(_ consentManager: STKConsentManager) {}
    
    func consentManager(_ consentManager: STKConsentManager, didFailToPresent error: Error) {
        initializeAppodealSDK()
    }
    
    func consentManagerDidDismissDialog(_ consentManager: STKConsentManager) {
        initializeAppodealSDK()
    }
}
