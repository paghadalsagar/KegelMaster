//
//  Reminder.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 13, 2020

import Foundation


class Reminder : NSObject, NSCoding{

    var iD : String!
    var rEMINDERDATE : String!
    var rEMINDERTIME : String!
    var rQSTCODE : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        iD = dictionary["ID"] as? String
        rEMINDERDATE = dictionary["REMINDER_DATE"] as? String
        rEMINDERTIME = dictionary["REMINDER_TIME"] as? String
        rQSTCODE = dictionary["RQST_CODE"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if iD != nil{
            dictionary["ID"] = iD
        }
        if rEMINDERDATE != nil{
            dictionary["REMINDER_DATE"] = rEMINDERDATE
        }
        if rEMINDERTIME != nil{
            dictionary["REMINDER_TIME"] = rEMINDERTIME
        }
        if rQSTCODE != nil{
            dictionary["RQST_CODE"] = rQSTCODE
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        iD = aDecoder.decodeObject(forKey: "ID") as? String
        rEMINDERDATE = aDecoder.decodeObject(forKey: "REMINDER_DATE") as? String
        rEMINDERTIME = aDecoder.decodeObject(forKey: "REMINDER_TIME") as? String
        rQSTCODE = aDecoder.decodeObject(forKey: "RQST_CODE") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if iD != nil{
            aCoder.encode(iD, forKey: "ID")
        }
        if rEMINDERDATE != nil{
            aCoder.encode(rEMINDERDATE, forKey: "REMINDER_DATE")
        }
        if rEMINDERTIME != nil{
            aCoder.encode(rEMINDERTIME, forKey: "REMINDER_TIME")
        }
        if rQSTCODE != nil{
            aCoder.encode(rQSTCODE, forKey: "RQST_CODE")
        }
    }
}