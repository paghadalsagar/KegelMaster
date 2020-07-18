//
//  ExerciseListViaDay.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 11, 2020

import Foundation


class ExerciseListViaDay : NSObject, NSCoding{

    var currentlyDay : String!
    var dayName : String!
    var exerciseIcon : String!
    var exerciseIsRest : String!
    var exerciseLevel : String!
    var exerciseTime : String!
    var exrDayDonePercentage : String!
    var iD : String!
    var isExerciseDayDone : Bool!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        currentlyDay = dictionary["CurrentlyDay"] as? String
        dayName = dictionary["DayName"] as? String
        exerciseIcon = dictionary["ExerciseIcon"] as? String
        exerciseIsRest = dictionary["ExerciseIsRest"] as? String
        exerciseLevel = dictionary["ExerciseLevel"] as? String
        exerciseTime = dictionary["ExerciseTime"] as? String
        exrDayDonePercentage = dictionary["ExrDayDonePercentage"] as? String
        iD = dictionary["ID"] as? String
        isExerciseDayDone = dictionary["IsExerciseDayDone"] as? Bool
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if currentlyDay != nil{
            dictionary["CurrentlyDay"] = currentlyDay
        }
        if dayName != nil{
            dictionary["DayName"] = dayName
        }
        if exerciseIcon != nil{
            dictionary["ExerciseIcon"] = exerciseIcon
        }
        if exerciseIsRest != nil{
            dictionary["ExerciseIsRest"] = exerciseIsRest
        }
        if exerciseLevel != nil{
            dictionary["ExerciseLevel"] = exerciseLevel
        }
        if exerciseTime != nil{
            dictionary["ExerciseTime"] = exerciseTime
        }
        if exrDayDonePercentage != nil{
            dictionary["ExrDayDonePercentage"] = exrDayDonePercentage
        }
        if iD != nil{
            dictionary["ID"] = iD
        }
        if isExerciseDayDone != nil{
            dictionary["IsExerciseDayDone"] = isExerciseDayDone
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        currentlyDay = aDecoder.decodeObject(forKey: "CurrentlyDay") as? String
        dayName = aDecoder.decodeObject(forKey: "DayName") as? String
        exerciseIcon = aDecoder.decodeObject(forKey: "ExerciseIcon") as? String
        exerciseIsRest = aDecoder.decodeObject(forKey: "ExerciseIsRest") as? String
        exerciseLevel = aDecoder.decodeObject(forKey: "ExerciseLevel") as? String
        exerciseTime = aDecoder.decodeObject(forKey: "ExerciseTime") as? String
        exrDayDonePercentage = aDecoder.decodeObject(forKey: "ExrDayDonePercentage") as? String
        iD = aDecoder.decodeObject(forKey: "ID") as? String
        isExerciseDayDone = aDecoder.decodeObject(forKey: "IsExerciseDayDone") as? Bool
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if currentlyDay != nil{
            aCoder.encode(currentlyDay, forKey: "CurrentlyDay")
        }
        if dayName != nil{
            aCoder.encode(dayName, forKey: "DayName")
        }
        if exerciseIcon != nil{
            aCoder.encode(exerciseIcon, forKey: "ExerciseIcon")
        }
        if exerciseIsRest != nil{
            aCoder.encode(exerciseIsRest, forKey: "ExerciseIsRest")
        }
        if exerciseLevel != nil{
            aCoder.encode(exerciseLevel, forKey: "ExerciseLevel")
        }
        if exerciseTime != nil{
            aCoder.encode(exerciseTime, forKey: "ExerciseTime")
        }
        if exrDayDonePercentage != nil{
            aCoder.encode(exrDayDonePercentage, forKey: "ExrDayDonePercentage")
        }
        if iD != nil{
            aCoder.encode(iD, forKey: "ID")
        }
        if isExerciseDayDone != nil{
            aCoder.encode(isExerciseDayDone, forKey: "IsExerciseDayDone")
        }
    }
}
