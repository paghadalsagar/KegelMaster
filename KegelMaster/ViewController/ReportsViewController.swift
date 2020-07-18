//
//  ReportsViewController.swift
//  KegelMaster
//
//  Created by iMac on 14/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var viewBarChat: BasicBarChart!
    
    //MARK:- Variable
    fileprivate var arrLevelData:[ExerciseListViaDay] = [ExerciseListViaDay]()
    
    //MARK:- UIView Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let dataEntries = generateEmptyDataEntries()
        viewBarChat.updateDataEntries(dataEntries: dataEntries, animated: true)
        
    }
    
    func generateEmptyDataEntries() -> [DataEntry] {
        let query = "SELECT * FROM EXR_PLANS"
        let arrData = SqlLiteManger().getData(query: query)
        
        var result: [DataEntry] = []
        for (index,dataLevel) in arrData.enumerated(){
            let dataOfLevel = ExerciseListViaDay.init(fromDictionary: dataLevel as! [String : Any])
            let dataProgress = CGFloat((Float(dataOfLevel.exrDayDonePercentage ?? "0.0") ?? 0.0) / 100)
            let stDisplayTitle: String = "L\(dataOfLevel.exerciseLevel ?? ""):D\(dataOfLevel.dayName ?? "")"
            if dataOfLevel.exerciseIsRest == "false"{
                if (index % 2 == 0){
                    result.append(DataEntry(color: #colorLiteral(red: 0.9803921569, green: 0.4, blue: 0.003921568627, alpha: 1), height:Float(dataProgress), textValue: "\(Float(dataOfLevel.exrDayDonePercentage ?? "0.0") ?? 0.0)", title: stDisplayTitle))
                }else if (index % 3 == 0){
                    result.append(DataEntry(color: #colorLiteral(red: 0.9600813985, green: 0.7829037309, blue: 0.004755125847, alpha: 1), height:Float(dataProgress), textValue: "\(Float(dataOfLevel.exrDayDonePercentage ?? "0.0") ?? 0.0)", title: stDisplayTitle))
                }else if (index % 4 == 0){
                    result.append(DataEntry(color: #colorLiteral(red: 0.4148338437, green: 0.5863669515, blue: 0.1203584448, alpha: 1), height:Float(dataProgress), textValue: "\(Float(dataOfLevel.exrDayDonePercentage ?? "0.0") ?? 0.0)", title: stDisplayTitle))
                }else if (index % 5 == 0){
                    result.append(DataEntry(color: #colorLiteral(red: 0.6900904775, green: 0.3977326751, blue: 0.2102888227, alpha: 1), height:Float(dataProgress), textValue: "\(Float(dataOfLevel.exrDayDonePercentage ?? "0.0") ?? 0.0)", title: stDisplayTitle))
                }else{
                    result.append(DataEntry(color: #colorLiteral(red: 0.7557453513, green: 0.1497770846, blue: 0.3050006032, alpha: 1), height:Float(dataProgress), textValue: "\(Float(dataOfLevel.exrDayDonePercentage ?? "0.0") ?? 0.0)", title: stDisplayTitle))
                }
            }
        }
        
        
        //        result.append(DataEntry(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), height: 0.2, textValue: "\(30)", title: "L1:D1"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), height: 0.5, textValue: "\(50)", title: "L1:D2"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), height: 0.1, textValue: "\(10)", title: "L1:D3"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), height: 0.3, textValue: "\(30)", title: "L1:D4"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), height: 0.4, textValue: "\(40)", title: "L1:D5"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), height: 0.6, textValue: "\(60)", title: "L1:D6"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), height: 0.3, textValue: "\(30)", title: "L1:D7"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), height: 0.1, textValue: "\(10)", title: "L2:D1"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), height: 0.6, textValue: "\(60)", title: "L2:D2"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), height: 0.0, textValue: "\(00)", title: "L2:D3"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), height: 0.2, textValue: "\(20)", title: "L2:D4"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), height: 0.0, textValue: "\(00)", title: "L2:D5"))
        //        result.append(DataEntry(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1), height: 0.0, textValue: "\(00)", title: "L2:D6"))
        
        return result
    }
    
}
