//
//  ExercisesViewController.swift
//  KegelMaster
//
//  Created by iMac on 11/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit
import AudioToolbox
import Appodeal

class ExercisesViewController: UIViewController {
    
    //MARK:- Outlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRepetition: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var viewExercises: UIView!
    @IBOutlet weak var lblExercisesTitle: UILabel!
    @IBOutlet weak var lblCompleteLevel: UILabel!
    @IBOutlet weak var bannerView: APDBannerView!
    
    //MARK:- Variable
    internal var arrExercisesList: [ExerciseList] = [ExerciseList]()
    fileprivate var exercisesNumner: Int = 0
    fileprivate var tenseTimer = Timer()
    fileprivate var relaxTimer = Timer()
    
    fileprivate var repetition: Int = 0
    fileprivate var tenseTime: Int = 0
    fileprivate var relaxTime: Int = 0
    fileprivate var completeExercises: Int = 0
    
    //MARK:- UIView Controller Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCompleteLevel.isHidden = true
        self.setData()
        if !UserDefault.getIsPurchase(){
            self.setup()
            Appodeal.setInterstitialDelegate(self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setData(){
        completeExercises = 0
        let dataOfExercises = arrExercisesList[exercisesNumner]
        lblTitle.text = "\(dataOfExercises.tenseRelax ?? "0")sec \(NSLocalizedString("Tense", comment: "")),\(dataOfExercises.tenseRelax ?? "0")sec \(NSLocalizedString("Relax", comment: ""))"
        lblRepetition.text = "\(NSLocalizedString("Repetition", comment: "")): x\(dataOfExercises.repetitions ?? "0")"
        repetition = Int(dataOfExercises.repetitions ?? "0") ?? 0
        self.setTimer()
    }
    
    func setTimer(){
        let dataOfExercises = arrExercisesList[exercisesNumner]
        lblExercisesTitle.text = "\(NSLocalizedString("Tense", comment: ""))"
        lblTimer.text = dataOfExercises.tenseRelax ?? "0"
        viewExercises.backgroundColor = UIColor().HexToColor(hexString: "#F22221")
        tenseTime = Int(dataOfExercises.tenseRelax ?? "0") ?? 0
        relaxTime = Int(dataOfExercises.tenseRelax ?? "0") ?? 0
        tenseTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tenseTimerAction), userInfo: nil, repeats: true)
    }
    
    //MARK: Timer Action
    @objc func tenseTimerAction()
    {
        let dataOfExercises = arrExercisesList[exercisesNumner]
        if tenseTime > 0{
            tenseTime -= 1
            lblTimer.text = "\(tenseTime)"
            if UserDefault.getIsVibration(){
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                //                sleep(1)
            }
            
            //            print("tense == \(tenseTime)")
        }else if tenseTime == 0{
            tenseTimer.invalidate()
            lblExercisesTitle.text = "\(NSLocalizedString("Relax", comment: ""))"
            lblTimer.text = dataOfExercises.tenseRelax ?? "0"
            viewExercises.backgroundColor = UIColor().HexToColor(hexString: "#627AD0")
            relaxTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(relaxTimerAction), userInfo: nil, repeats: true)
        }
        
        
    }
    
    @objc func relaxTimerAction()
    {
        if relaxTime > 0{
            relaxTime -= 1
            lblTimer.text = "\(relaxTime)"
            //            print("relax == \(relaxTime)")
        }else if tenseTime == 0{
            relaxTimer.invalidate()
            self.setTimer()
        }
        
        if tenseTime == 0 && relaxTime == 0{
            completeExercises += 1
            if completeExercises == repetition{
                relaxTimer.invalidate()
                tenseTimer.invalidate()
                print("Complete Level")
                exercisesNumner += 1
                self.updateDB()
                if arrExercisesList.count == exercisesNumner {
                    lblCompleteLevel.isHidden = false
                    relaxTimer.invalidate()
                    tenseTimer.invalidate()
                    if !UserDefault.getIsPurchase(){
                        Appodeal.isInitalized(for: .interstitial)
                        Appodeal.canShow(.interstitial, forPlacement: "Kegel")
                        Appodeal.showAd(.interstitial,forPlacement: "Kegel",rootViewController: self)
                    }
                }else{
                    self.setData()
                }
            }
        }
    }
    
    func updateDB(){
        let dataOfExercises = arrExercisesList[exercisesNumner - 1]
        let donePercentage  = (exercisesNumner * 100) / arrExercisesList.count
        let query = "UPDATE EXR_PLANS SET ExrDayDonePercentage = '\(donePercentage)' WHERE Id = '\(dataOfExercises.iD ?? "0")'"
        let isUpdate = SqlLiteManger().UpdateData(query: query)
        print("update Table == \(isUpdate)")
    }
    
    //MARK:- UIButton Action
    @IBAction func btnBackAction(_ sender: UIButton) {
        relaxTimer.invalidate()
        tenseTimer.invalidate()
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Other
    func setup() {
        let bannerSize = kAPDAdSize320x50
        bannerView.adSize = bannerSize
        bannerView.loadAd()
    }
    
}

extension ExercisesViewController: AppodealInterstitialDelegate {
    func interstitialDidLoadAdIsPrecache(_ precache: Bool) {}
    func interstitialDidFailToLoadAd() {}
    func interstitialDidFailToPresent() {}
    func interstitialWillPresent() {}
    func interstitialDidDismiss() {}
    func interstitialDidClick() {}
}

extension ExercisesViewController: AppodealBannerViewDelegate {
    func bannerViewDidLoadAd(_ bannerView: APDBannerView, isPrecache precache: Bool) {}
    func bannerView(_ bannerView: APDBannerView, didFailToLoadAdWithError error: Error) {}
    func bannerViewDidInteract(_ bannerView: APDBannerView) {}
    func bannerViewDidShow(_ bannerView: APDBannerView) {}
}
