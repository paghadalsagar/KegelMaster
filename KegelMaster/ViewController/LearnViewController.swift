//
//  LearnViewController.swift
//  KegelMaster
//
//  Created by iMac on 12/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- Outlet
    @IBOutlet weak var tablviewHelpList: UITableView!
    
    //MARK:- Variable
    fileprivate var arrData:[[String:AnyObject]] = [[String:AnyObject]]()
    
    //MARK:- UIView Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrData = getHelpTutorial()
    }
    
    //MARK:- UIButton Action
    @objc func btnCellAction(_ sender: UIButton) {
        var data = arrData[sender.tag]
        if data[KEY_EXPAND] as? String == "0"{
            data[KEY_EXPAND] = "1" as AnyObject
        }else{
            data[KEY_EXPAND] = "0" as AnyObject
        }
        arrData[sender.tag] = data
        tablviewHelpList.reloadData()
    }
    
    //MARK:- UITableView DataSource and Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = arrData[section]
        if data[KEY_EXPAND] as? String == "1"{
            let arrString: [String] = data[KEY_VALUE] as! [String]
            return arrString.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: HelpTutorialCell! = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE_HELP_TUTORIAL) as? HelpTutorialCell
        if cell == nil {
            tableView.register(UINib(nibName: CELL_IDENTIFIRE_HELP_TUTORIAL, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIRE_HELP_TUTORIAL)
            cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE_HELP_TUTORIAL) as? HelpTutorialCell
        }
        let data = arrData[indexPath.section]
        let arrString: [String] = data[KEY_VALUE] as! [String]
        let stData = arrString[indexPath.row]
        cell.lblHelpDesc.text = NSLocalizedString(stData, comment: "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerCell: HelpTutorialHeaderCell! = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE_HELP_TUTORIAL_HEADER) as? HelpTutorialHeaderCell
        if headerCell == nil {
            tableView.register(UINib(nibName: CELL_IDENTIFIRE_HELP_TUTORIAL_HEADER, bundle: nil), forCellReuseIdentifier: CELL_IDENTIFIRE_HELP_TUTORIAL_HEADER)
            headerCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE_HELP_TUTORIAL_HEADER) as? HelpTutorialHeaderCell
        }
        let data = arrData[section]
        headerCell.lblTitle.text = NSLocalizedString(data[KEY_TITLE] as? String ?? "", comment: "")
        if data[KEY_EXPAND] as? String == "0"{
            headerCell.imageviewArrow.image = UIImage(named: "icn_Down_Arrow")
        }else{
            headerCell.imageviewArrow.image = UIImage(named: "icn_Up_Arrow")
        }
        headerCell.btnCellAction.tag = section
        headerCell.btnCellAction.addTarget(self, action: #selector(btnCellAction), for: .touchUpInside)
        
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}
