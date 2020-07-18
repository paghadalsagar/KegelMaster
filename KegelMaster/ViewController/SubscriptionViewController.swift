//
//  SubscriptionViewController.swift
//  KegelMaster
//
//  Created by iMac on 17/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit
import StoreKit

class SubscriptionViewController: UIViewController, SKPaymentTransactionObserver,SKProductsRequestDelegate {
    
    //MARK:- Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNoAds: UILabel!
    @IBOutlet weak var lblUnlockLevels: UILabel!
    @IBOutlet weak var lblUnlockReminder: UILabel!
    @IBOutlet weak var lblBtnTitle: UILabel!
    @IBOutlet weak var lblBtnDesc: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var btnRestore: UIButton!
    @IBOutlet weak var lblTermsDesc: UILabel!
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var lblPrivacyDesc1: UILabel!
    @IBOutlet weak var btnPrivacy: UIButton!
    @IBOutlet weak var lblPrivacyDesc2: UILabel!
    
    //MARK:- Variable
    var producttID = ""
    var Selected_PRODUCT_ID = ""
    
    var subscriptionList:[SKProduct] = [SKProduct]()
    
    //MARK:- UIView Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Selected_PRODUCT_ID = subscriptionList[0].productIdentifier
        if #available(iOS 11.2, *) {
            if let period = subscriptionList[0].introductoryPrice?.subscriptionPeriod {
                print("Start your \(period.numberOfUnits) \(unitName(unitRawValue: period.unit.rawValue)) free trial")
            }
        } else {
            // Fallback on earlier versions
            // Get it from your server via API
        }
    }
    
    func unitName(unitRawValue:UInt) -> String {
        switch unitRawValue {
        case 0: return "days"
        case 1: return "weeks"
        case 2: return "months"
        case 3: return "years"
        default: return ""
        }
    }
    //MARK:- Other Methods
    func setText(){
        lblTitle.text  = "\(NSLocalizedString("Diamond user", comment: ""))"
        lblNoAds.text  = "\(NSLocalizedString("No ads will display", comment: ""))"
        lblUnlockLevels.text  = "\(NSLocalizedString("Unlock All Levels", comment: ""))"
        lblUnlockReminder.text  = "\(NSLocalizedString("Unlimited Reminders", comment: ""))"
        lblBtnTitle.text  = "\(NSLocalizedString("TRY FOR FREE", comment: ""))"
        lblBtnDesc.text  = "\(NSLocalizedString("3 days free then", comment: "")) \(subscriptionList[0].localizedPrice) \(NSLocalizedString("per week.you can canel subscription at any time", comment: ""))"
        lblNote.text  = "\(NSLocalizedString("Your membership starts as soon as you set up payment and subscribe with itunes.", comment: ""))\n \n\(NSLocalizedString("Your weekly charge will occur on the last day of the current billing period. We’ll renew your membership for you(unless auto-renew is turned off 24 hours before the end of your billing cycle). Once you’re a member,you can manage your subscription or turn off auto-renewal under Account Settings.", comment: ""))\n"
    
        btnRestore.setTitle("\(NSLocalizedString("RESTORE", comment: ""))", for: UIControl.State.normal)
        
        lblTermsDesc.text  = "\(NSLocalizedString("By continuing, you are agreeing to these", comment: ""))"
        btnTerms.setTitle("\(NSLocalizedString("Terms.", comment: ""))", for: UIControl.State.normal)
        
        lblPrivacyDesc1.text = "\(NSLocalizedString("See the", comment: ""))"
        btnPrivacy.setTitle("\(NSLocalizedString("privacy", comment: ""))", for: UIControl.State.normal)
        lblPrivacyDesc2.text = "\(NSLocalizedString("statement", comment: ""))"
    }
    
    //MARK:- UIButton Action
    @IBAction func btnCloseAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubsciptionAction(_ sender: UIButton) {
        purchaseProducts(product: subscriptionList[0])
    }
    
    @IBAction func btnRestoreAction(_ sender: UIButton) {
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
    }
    
    @IBAction func btnTermsAction(_ sender: UIButton) {
        if let url = URL(string: "https://www.upwork.com/freelancers/~019ffcbe85b537e9a4?viewMode=1") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    @IBAction func btnPrivacyAction(_ sender: UIButton) {
        if let url = URL(string: "https://www.upwork.com/freelancers/~019ffcbe85b537e9a4?viewMode=1") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    customDesign.stopActivityIndicator()
                    if let paymentTransaction = transaction as? SKPaymentTransaction {
                        SKPaymentQueue.default().finishTransaction(paymentTransaction)
                    }
                    if producttID == Selected_PRODUCT_ID {
                        print("You've successfully purchased")
                        let _ = SPToastView.init("You've successfully purchased")
                        UserDefault.setIsPurchase(true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    break
                case .failed:
                    print("Purchase failed!")
                    customDesign.stopActivityIndicator()
                    UserDefault.setIsPurchase(false)
                    if trans.error != nil {
                        let _ = SPToastView.init("\(trans.error!.localizedDescription)")
                        print(trans.error!)
                    }
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    customDesign.stopActivityIndicator()
                    UserDefault.setIsPurchase(false)
                    print("restored")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                default: break
                }
            }
        }
    }
    
    //MARK:- SubscriptionView Delegate
    func subscriptionPuchaseClick(_ Btn: UIButton, purchaseProduct: SKProduct, productID: String) {
        Selected_PRODUCT_ID = productID
        
    }
    
    // MARK: - Make purchase of a product
    func canMakePurchases() -> Bool { return SKPaymentQueue.canMakePayments() }
    
    func purchaseProducts(product: SKProduct) {
        if self.canMakePurchases() {
            customDesign.startActivityIndicator(self.view)
            print("Purchasing...")
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            print("Product to Purchase: \(product.productIdentifier)")
            producttID = product.productIdentifier
        }
            // IAP Purchases disabled on the Device
        else{
            let _ = SPToastView.init("Purchases are disabled in your device!")
        }
    }
    
    
}
extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        return formatter.string(from: price)!
    }
}
