//
//  SettingsViewController.swift
//  KegelMaster
//
//  Created by iMac on 13/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit
import DropDown
import StoreKit
import AudioToolbox

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,SKProductsRequestDelegate, SKPaymentTransactionObserver{
    
    //MARK:- Outlet
    @IBOutlet weak var viewLanguage: UIView!
    @IBOutlet weak var viewVibrationMode: UIView!
    @IBOutlet weak var tableviewReminder: UITableView!
    @IBOutlet weak var constraintTableviewReminderHeight: NSLayoutConstraint!
    @IBOutlet weak var viewReminder: UIView!
    @IBOutlet weak var btnLanguageChnage: UIButton!
    @IBOutlet weak var lblCurrentLanguageNote: UILabel!
    @IBOutlet weak var switchVibration: UISwitch!
    
    //MARK:- Variable
    let languageDropDown = DropDown()
    fileprivate var arrReminder: [Reminder] = [Reminder]()
    let notificationCenter = UNUserNotificationCenter.current()
    let obj_AppDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var productsRequest = SKProductsRequest()
    var iapProducts = [SKProduct]()
    
    //MARK:- UIView Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
  
        lblCurrentLanguageNote.text = "\(NSLocalizedString("Current language", comment: "")):\(self.getSelectedLanguage())"
        
        self.setShadow()
        switchVibration.isOn = UserDefault.getIsVibration()
        
        languageDropDown.anchorView = btnLanguageChnage
        languageDropDown.dataSource = ["\(NSLocalizedString("Select language", comment: ""))", "English", "Russian", "Español", "Deutsch", "Français", "Português", "日本語"]
        languageDropDown.backgroundColor = UIColor.white
        languageDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            if index == 0 { return }
            self.lblCurrentLanguageNote.text = "\(NSLocalizedString("Current language", comment: "")):\(item)"
            
            if "\(index)" == UserDefault.geSelectedLanguage(){
                let _ = SPToastView.init("Language already selected!")
                return
            }
            
            if index == 1{
                UserDefault.setSelectedLanguage("1")
                self.setRoot()
                PPLocalization.sharedInstance.setLanguage(language: "en")
            }else if index == 2{
                UserDefault.setSelectedLanguage("2")
                self.setRoot()
                PPLocalization.sharedInstance.setLanguage(language: "ru")
            }else if index == 3{
                UserDefault.setSelectedLanguage("3")
                self.setRoot()
                PPLocalization.sharedInstance.setLanguage(language: "es")
            }else if index == 4{
                UserDefault.setSelectedLanguage("4")
                self.setRoot()
                PPLocalization.sharedInstance.setLanguage(language: "de")
            }else if index == 5{
                UserDefault.setSelectedLanguage("5")
                self.setRoot()
                PPLocalization.sharedInstance.setLanguage(language: "fr")
            }else if index == 6{
                UserDefault.setSelectedLanguage("6")
                self.setRoot()
                PPLocalization.sharedInstance.setLanguage(language: "pt-PT")
            }else if index == 7{
                UserDefault.setSelectedLanguage("7")
                self.setRoot()
                PPLocalization.sharedInstance.setLanguage(language: "ja")
            }
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getReminer()
    }
    
    func setRoot(){
        self.dismiss(animated: true, completion: nil)
        self.navigationController!.dismiss(animated: true, completion: nil)
        self.navigationController!.popViewController(animated: true)
        self.navigationItem.hidesBackButton = true
    }
    
    func setShadow(){
        viewLanguage.layer.shadowColor = UIColor.gray.cgColor
        viewLanguage.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewLanguage.layer.shadowOpacity = 0.7
        viewLanguage.layer.shadowRadius = 1.0
        viewLanguage.clipsToBounds = false
        viewLanguage.layer.masksToBounds = true
        
        viewLanguage.layer.cornerRadius = 10.0
        viewLanguage.layer.masksToBounds = false
        viewLanguage.setNeedsLayout()
        viewLanguage.setNeedsDisplay()
        
        
        viewVibrationMode.layer.shadowColor = UIColor.gray.cgColor
        viewVibrationMode.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewVibrationMode.layer.shadowOpacity = 0.7
        viewVibrationMode.layer.shadowRadius = 1.0
        viewVibrationMode.clipsToBounds = false
        viewVibrationMode.layer.masksToBounds = true
        
        viewVibrationMode.layer.cornerRadius = 10.0
        viewVibrationMode.layer.masksToBounds = false
        viewVibrationMode.setNeedsLayout()
        viewVibrationMode.setNeedsDisplay()
        
        
        viewReminder.layer.shadowColor = UIColor.gray.cgColor
        viewReminder.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewReminder.layer.shadowOpacity = 0.7
        viewReminder.layer.shadowRadius = 1.0
        viewReminder.clipsToBounds = false
        viewReminder.layer.masksToBounds = true
        
        viewReminder.layer.cornerRadius = 10.0
        viewReminder.layer.masksToBounds = false
        viewReminder.setNeedsLayout()
        viewReminder.setNeedsDisplay()
    }
    
    func getSelectedLanguage() -> String {
        var selectedLanguage: String = ""
        if "1" == UserDefault.geSelectedLanguage(){
            selectedLanguage =  "English"
        }else  if "2" == UserDefault.geSelectedLanguage(){
            selectedLanguage =  "Russian"
        }else  if "3" == UserDefault.geSelectedLanguage(){
            selectedLanguage =  "Español"
        }else  if "4" == UserDefault.geSelectedLanguage(){
            selectedLanguage =  "Deutsch"
        }else  if "5" == UserDefault.geSelectedLanguage(){
            selectedLanguage =  "Français"
        }else  if "6" == UserDefault.geSelectedLanguage(){
            selectedLanguage =  "Português"
        }else  if "7" == UserDefault.geSelectedLanguage(){
            selectedLanguage =  "日本語"
        }
        
        return selectedLanguage
    }
    
    func openReminder(){
        let myDatePicker: UIDatePicker = UIDatePicker()
        let newWidth = UIScreen.main.bounds.width * 0.90
        
        myDatePicker.timeZone = NSTimeZone.local
        myDatePicker.frame = CGRect(x: 0, y: 15, width: newWidth, height: 300)
        let alert = UIAlertController(title: "", message: "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        alert.view.addSubview(myDatePicker)
        let somethingAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { (alert) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: myDatePicker.date)
            self.insertReminder(dateString, selectedReminderDate: myDatePicker.date)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(somethingAction)
        alert.addAction(cancelAction)
        // Filtering width constraints of alert base view width
        let widthConstraints = alert.view.constraints.filter({ return $0.firstAttribute == .width })
        alert.view.removeConstraints(widthConstraints)
        // Here you can enter any width that you want
        
        // Adding constraint for alert base view
        let widthConstraint = NSLayoutConstraint(item: alert.view!,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: newWidth)
        alert.view.addConstraint(widthConstraint)
        let firstContainer = alert.view.subviews[0]
        // Finding first child width constraint
        let constraint = firstContainer.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        firstContainer.removeConstraints(constraint)
        // And replacing with new constraint equal to alert.view width constraint that we setup earlier
        alert.view.addConstraint(NSLayoutConstraint(item: firstContainer,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: alert.view,
                                                    attribute: .width,
                                                    multiplier: 1.0,
                                                    constant: 0))
        // Same for the second child with width constraint with 998 priority
        let innerBackground = firstContainer.subviews[0]
        let innerConstraints = innerBackground.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        innerBackground.removeConstraints(innerConstraints)
        firstContainer.addConstraint(NSLayoutConstraint(item: innerBackground,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: firstContainer,
                                                        attribute: .width,
                                                        multiplier: 1.0,
                                                        constant: 0))
        
        present(alert, animated: true, completion: nil)
    }
    
    func fetchAvailableProducts() {
          guard let identifier = productIdentifiers as? Set<String> else { return }
          productsRequest = SKProductsRequest(productIdentifiers: identifier)
          productsRequest.delegate = self
          productsRequest.start()
      }
    
    //MARK:- UIButton Action
    @IBAction func btnAddReminderAction(_ sender: UIButton) {
        if !UserDefault.getIsPurchase() && self.arrReminder.count > 2{
            self.fetchAvailableProducts()
        }else if !UserDefault.getIsPurchase() && self.arrReminder.count <= 2{
            self.openReminder()
        }else{
             self.openReminder()
        }
    }
    
    @IBAction func btnLanguageChangeAction(_ sender: UIButton) {
        languageDropDown.show()
    }
    
    @objc func btnRemoveReminderAction(_ sender: UIButton) {
        
        let data = self.arrReminder[sender.tag]
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["KegelReminder\(data.iD ?? "")"])
        let query = "DELETE FROM REMINDER WHERE ID = '\(data.iD ?? "0")';"
        
        let _ = SqlLiteManger().UpdateData(query: query)
        self.getReminer()
    }
    
    @IBAction func switchVibrationModeAction(_ sender: UISwitch) {
        UserDefault.setIsVibration(sender.isOn)
        
    }
    //MARK:- Other Methods
    func setLocalNotification(_ selectedDate:Date,stNotificationIdentifire:String){
        let content = UNMutableNotificationContent()
        let categoryIdentifire = "KegelReminder"
        
        content.title = "Welcome back Kegel"
        content.body = "it's Kegel time"
        content.sound = UNNotificationSound.default
        content.badge = 0
        content.categoryIdentifier = categoryIdentifire
        let triggerWeekly = Calendar.current.dateComponents([.day,.month,.year, .hour, .minute], from: selectedDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: false)
        let identifier = stNotificationIdentifire
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
        
        let snoozeAction = UNNotificationAction(identifier: "Open", title: "Open", options: [.foreground])
        let deleteAction = UNNotificationAction(identifier: "DeleteAction", title: "Delete", options: [.destructive])
        let category = UNNotificationCategory(identifier: categoryIdentifire,
                                              actions: [snoozeAction, deleteAction],
                                              intentIdentifiers: [],
                                              options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func insertReminder(_ stSelctedTimeDate: String,selectedReminderDate: Date){
        
        let query = "INSERT INTO REMINDER (REMINDER_DATE,REMINDER_TIME,RQST_CODE) VALUES ('','\(stSelctedTimeDate)',0);"
        let isInsert = SqlLiteManger().UpdateData(query: query)
        self.getReminer()
        if isInsert{
            self.setLocalNotification(selectedReminderDate, stNotificationIdentifire: "KegelReminder\(self.arrReminder.last?.iD ?? "")")
        }
    }
    
    func getReminer(){
        self.arrReminder.removeAll()
        let query = "SELECT * FROM REMINDER"
        let arrData = SqlLiteManger().getData(query: query)
        for dataLevel in arrData{
            self.arrReminder.append(Reminder.init(fromDictionary: dataLevel as! [String : Any]))
        }
        constraintTableviewReminderHeight.constant = REMINDERLISTCELL_HEIGHT * CGFloat(self.arrReminder.count)
        tableviewReminder.reloadData()
    }
    
    func dateConvertTime(_ stDate:String) -> String{
        if stDate.isEmpty{ return "" }
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let bpDate = dateFormatter.date(from: stDate)
        dateFormatter.dateFormat = "hh:mm a"
        return "\(dateFormatter.string(from: bpDate!))"
    }
    
    func dateConvertDate(_ stDate:String) -> String{
        if stDate.isEmpty{ return "" }
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let bpDate = dateFormatter.date(from: stDate)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return "\(dateFormatter.string(from: bpDate!))"
    }
    
    //MARK:- UItableview Method
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrReminder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = ReminderListCell()
        if let c = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE_REMINDERLIST) { cell = c as! ReminderListCell }
        else { cell = Bundle.main.loadNibNamed(CELL_IDENTIFIRE_REMINDERLIST, owner: self, options: nil)?[0] as! ReminderListCell }
        let data = arrReminder[indexPath.row]
        cell.lblTime.text = dateConvertTime(data.rEMINDERTIME ?? "")
        cell.lblDate.text = dateConvertDate(data.rEMINDERTIME ?? "")
        cell.btnRemove.tag = indexPath.row
        cell.btnRemove.addTarget(self, action: #selector(btnRemoveReminderAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //MARK:- UITableview DELEGATE
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return REMINDERLISTCELL_HEIGHT
    }
    
    //MARK:- SKProductsRequestDelegate
       func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
           if response.products.count > 0 {
               iapProducts = response.products
               print(response.invalidProductIdentifiers)
              if !iapProducts.isEmpty{
                   print(iapProducts)
                  DispatchQueue.main.async {
                      guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionViewController") as? SubscriptionViewController else { return  }
                      VC.subscriptionList = self.iapProducts
                      VC.modalPresentationStyle = .fullScreen
                      self.present(VC, animated: true, completion: nil)
                  }
                 
               }
           }
       }
      
       func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
       }
}
