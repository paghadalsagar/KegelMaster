//
//  ExercisesListViewController.swift
//  KegelMaster
//
//  Created by iMac on 11/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

class ExercisesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- Outlet
    @IBOutlet weak var tableviewExercisesList: UITableView!
    @IBOutlet weak var lblExercisesDay: UILabel!
    @IBOutlet weak var lblLevelName: UILabel!
    @IBOutlet weak var viewPlayBtn: UIView!
    @IBOutlet weak var imageviewPlayBtn: UIImageView!
    
    //MARK:- Variable
    fileprivate var arrExercisesList: [ExerciseList] = [ExerciseList]()
    internal var selectedExercise : ExerciseListViaDay?
    fileprivate var selectedColor: UIColor = color_Level1
    
    //MARK:- UIView Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let stLevel: String = selectedExercise?.exerciseLevel ?? "0"
        lblLevelName.text = "\(NSLocalizedString("Level", comment: "")) \(stLevel)"
        self.choseColor(stLevel)
        lblExercisesDay.text = "\(NSLocalizedString("Day", comment: "")) \(selectedExercise?.dayName ?? "0")"
        lblExercisesDay.textColor = selectedColor
        self.getExercisesData()
        self.setShadowStartBtn()
    }
    
    //MARK:- Other Methods
    func choseColor(_ selectedID:String){
        if selectedID == "1"{ //Level1
            selectedColor = color_Level1
        }else if selectedID == "2"{ //Level2
            selectedColor = color_Level2
        }else if selectedID == "3"{ //Level3
            selectedColor = color_Level3
        }else if selectedID == "4"{ //Level4
            selectedColor = color_Level4
        }else if selectedID == "5"{ //Level5
            selectedColor = color_Level5
        }else if selectedID == "6"{ //Level6
            selectedColor = color_Level6
        }else if selectedID == "7"{ //Level7
            selectedColor = color_Level7
        }
    }
    
    func getExercisesData(){
        self.arrExercisesList.removeAll()
        let query = "SELECT * FROM EXR_PLANS_2 WHERE ID = '\(selectedExercise?.iD ?? "0")'"
        let arrData = SqlLiteManger().getData(query: query)
        for dataExer in arrData{
            arrExercisesList.append(ExerciseList.init(fromDictionary: dataExer as! [String : Any]))
        }
        tableviewExercisesList.reloadData()
    }
    
    
    func setShadowStartBtn(){
        viewPlayBtn.layer.shadowColor = UIColor.gray.cgColor
        viewPlayBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewPlayBtn.layer.shadowOpacity = 0.9
        viewPlayBtn.layer.shadowRadius = 1.0
        viewPlayBtn.clipsToBounds = false
        viewPlayBtn.layer.masksToBounds = true
        
        viewPlayBtn.layer.cornerRadius = viewPlayBtn.bounds.width / 2
        viewPlayBtn.layer.masksToBounds = false
        viewPlayBtn.setNeedsLayout()
        viewPlayBtn.setNeedsDisplay()
        
        imageviewPlayBtn.image = imageviewPlayBtn.image?.withRenderingMode(.alwaysTemplate)
        imageviewPlayBtn.tintColor = selectedColor
    }
    
    //MARK:- UIButton Action
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnStartAction(_ sender: UIButton) {
        
        guard let VC = self.storyboard?.instantiateViewController(withIdentifier: "ExercisesViewController") as? ExercisesViewController else { return  }
        VC.arrExercisesList = self.arrExercisesList
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    //MARK:- UITableview DataSource and Delegate Method
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrExercisesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = ExercisesListCell()
        if let c = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIRE_EXERCISES_LIST) { cell = c as! ExercisesListCell }
        else { cell = Bundle.main.loadNibNamed(CELL_IDENTIFIRE_EXERCISES_LIST, owner: self, options: nil)?[0] as! ExercisesListCell }
        let dataExer = arrExercisesList[indexPath.row]
        cell.lblRepeter.text = "x\(dataExer.repetitions ?? "0")"
        cell.lblExerNote.text = "\(dataExer.tenseRelax ?? "0")sec \(NSLocalizedString("Tense", comment: "")),\(dataExer.tenseRelax ?? "0")sec \(NSLocalizedString("Relax", comment: ""))"
        cell.lblExerNote.textColor = selectedColor
        return cell
    }
    
    //MARK:- UITableview DELEGATE
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return EXERCISESLISTCELL_HEIGHT
    }
    
}
