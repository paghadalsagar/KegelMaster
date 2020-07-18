//
//  commonData.swift
//
//  Created by Sagar Paghadal on 5/11/19.
//

import Foundation
import UIKit

let ADV_ID                                          =  "cecc519de02eaa6216384ba507b1f656ee4d60851c15e4c8" //"dee74c5129f53fc629a44a690a02296694e3eef99f2d3a5f" 

let productIdentifiers             = NSSet(array: ["DIAMOND_USER_KEGEL"])

//MARK:- Defult Key
let KEY_ID                                          = "ID"
let KEY_TITLE                                       = "TITLE"
let KEY_VALUE                                       = "VALUE"
let KEY_EXPAND                                      = "KEY_EXPAND"

//MARK:- FONT



//MARK:- Cell Identifier
let CELL_IDENTIFIRE_MENU_HEADER              = "MenuHeaderCell"
let CELL_IDENTIFIRE_DAY_LIST                 = "DayListCell"
let CELL_IDENTIFIRE_EXERCISES_LIST           = "ExercisesListCell"
let CELL_IDENTIFIRE_HELP_TUTORIAL_HEADER     = "HelpTutorialHeaderCell"
let CELL_IDENTIFIRE_HELP_TUTORIAL            = "HelpTutorialCell"
let CELL_IDENTIFIRE_REMINDERLIST             = "ReminderListCell"

//MARK:- Cell Height
let DAYLISTCELL_HEIGHT:CGFloat                              = 80.0
let EXERCISESLISTCELL_HEIGHT:CGFloat                        = 85.0
let REMINDERLISTCELL_HEIGHT:CGFloat                        = 70.0

//MARK:- Static value
let color_Level1                                     = UIColor().HexToColor(hexString: "#ff4444")
let color_Level2                                     = UIColor().HexToColor(hexString: "#ffbb33")
let color_Level3                                     = UIColor().HexToColor(hexString: "#99cc00")
let color_Level4                                     = UIColor().HexToColor(hexString: "#ff4444")
let color_Level5                                     = UIColor().HexToColor(hexString: "#33b5e5")
let color_Level6                                     = UIColor().HexToColor(hexString: "#ffbb33")
let color_Level7                                     = UIColor().HexToColor(hexString: "#99cc00")

let SUCCESS_STATUS                                            = 1

let MED_Active                                                = "Active"
let MED_NOT_Active                                            = "Not Active"


let PRIORITY_LOW: UILayoutPriority              = UILayoutPriority(rawValue: 555)
let PRIORITY_HIGH: UILayoutPriority             = UILayoutPriority(rawValue: 999)

let IS_IPAD                                     = UIDevice.current.userInterfaceIdiom == .pad
let IS_IPHONE                                   = UIDevice.current.userInterfaceIdiom == .phone


let systemVerion                        = (UIDevice.current.systemVersion as NSString).floatValue
let IS_OS_10_DOWN                       = systemVerion < 10.0


let NOTIFICATION_MEDIEVENING            = "MediEvening"
let NOTIFICATION_MEDINOON               = "MediNoon"
let NOTIFICATION_MEDIMRNG               = "MediMrng"


//MARK:- Check Device Type
var isIpad : Bool { return UIDevice.current.userInterfaceIdiom == .pad }


func getMenuList() -> [[String:String]]{
    let dict = [KEY_ID:"0",KEY_TITLE:"1"]
    let dict1 = [KEY_ID:"1",KEY_TITLE:"2"]
    let dict2 = [KEY_ID:"2",KEY_TITLE:"3"]
    let dict3 = [KEY_ID:"3",KEY_TITLE:"4"]
    let dict4 = [KEY_ID:"4",KEY_TITLE:"5"]
    let dict5 = [KEY_ID:"5",KEY_TITLE:"6"]
    let dict6 = [KEY_ID:"6",KEY_TITLE:"7"]
    return [dict,dict1,dict2,dict3,dict4,dict5,dict6]
}

func getHelpTutorialSubMenu1() -> [String]{
    let st = "Kegel exercises are necessary to strengthen the pelvic floor muscles and include strengthening the muscles of the uterus and bladder."
    let st1 = "according to research, Kegel exercises help prevent pelvic floor prolapse and prevent or control urinary incontinence."
    return [st,st1]
}

func getHelpTutorialSubMenu2() -> [String]{
    let st = "BENEFITS: Kegel Exercises are effective in cases of urinary incontinence, vaginal prolapse caused by increased abdominal pressure."
    let st1 = "SEX LIFE: Kegel helps to improve blood circulation in the vagina, increase sexual arousal, get more pleasure from sex."
    let st2 = "PREGNANCY: Exercise can reduce pain during labor, as well as shorten the delivery time by relaxing and controlling the pelvic floor muscles."
    return [st,st1]
}

func getHelpTutorialSubMenu3() -> [String]{
    let st = "Kegel exercises can be used in cases of weak pelvic floor muscles, pregnancy, aging, childbirth, overweight, etc."
    return [st]
}

func getHelpTutorialSubMenu4() -> [String]{
    let st = "to strengthen the pelvic floor muscles, their rhythmic contraction is necessary."
    return [st]
}

func getHelpTutorialSubMenu5() -> [String]{
    let st = "the Muscles that contribute to slowing or stopping urination are the pelvic floor muscles."
    let st1 = "Insert your finger into the vagina and try to Compress the vaginal muscles. You should feel the vagina narrow and the pelvic floor rise up."
    return [st,st1]
}

func getHelpTutorial()  -> [[String:AnyObject]]{
    let data = [KEY_TITLE:"What are Kegel exercises for?" as AnyObject,KEY_VALUE: getHelpTutorialSubMenu1() as AnyObject,KEY_EXPAND:"0" as AnyObject]
    let data1 = [KEY_TITLE:"What are the benefits of these exercises?" as AnyObject,KEY_VALUE: getHelpTutorialSubMenu2() as AnyObject,KEY_EXPAND:"0" as AnyObject]
    let data2 = [KEY_TITLE:"What are Kegel exercises for ?" as AnyObject,KEY_VALUE: getHelpTutorialSubMenu3() as AnyObject,KEY_EXPAND:"0" as AnyObject]
    let data3 = [KEY_TITLE:"How to do Kegel exercises correctly?" as AnyObject,KEY_VALUE: getHelpTutorialSubMenu4() as AnyObject,KEY_EXPAND:"0" as AnyObject]
    let data4 = [KEY_TITLE:"Where are the pelvic floor muscles located?" as AnyObject,KEY_VALUE: getHelpTutorialSubMenu5() as AnyObject,KEY_EXPAND:"0" as AnyObject]
    return [data,data1,data2,data3,data4]
}
