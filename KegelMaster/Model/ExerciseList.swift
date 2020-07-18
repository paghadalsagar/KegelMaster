//
//  ExerciseList.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on July 11, 2020

import Foundation


class ExerciseList : NSObject, NSCoding{

    var currentlyOnExercise : String!
    var exerciseNote : String!
    var exerciseNumber : String!
    var iD : String!
    var repetitions : String!
    var tenseRelax : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        currentlyOnExercise = dictionary["CurrentlyOnExercise"] as? String
        exerciseNote = dictionary["ExerciseNote"] as? String
        exerciseNumber = dictionary["ExerciseNumber"] as? String
        iD = dictionary["ID"] as? String
        repetitions = dictionary["Repetitions"] as? String
        tenseRelax = dictionary["TenseRelax"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if currentlyOnExercise != nil{
            dictionary["CurrentlyOnExercise"] = currentlyOnExercise
        }
        if exerciseNote != nil{
            dictionary["ExerciseNote"] = exerciseNote
        }
        if exerciseNumber != nil{
            dictionary["ExerciseNumber"] = exerciseNumber
        }
        if iD != nil{
            dictionary["ID"] = iD
        }
        if repetitions != nil{
            dictionary["Repetitions"] = repetitions
        }
        if tenseRelax != nil{
            dictionary["TenseRelax"] = tenseRelax
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        currentlyOnExercise = aDecoder.decodeObject(forKey: "CurrentlyOnExercise") as? String
        exerciseNote = aDecoder.decodeObject(forKey: "ExerciseNote") as? String
        exerciseNumber = aDecoder.decodeObject(forKey: "ExerciseNumber") as? String
        iD = aDecoder.decodeObject(forKey: "ID") as? String
        repetitions = aDecoder.decodeObject(forKey: "Repetitions") as? String
        tenseRelax = aDecoder.decodeObject(forKey: "TenseRelax") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if currentlyOnExercise != nil{
            aCoder.encode(currentlyOnExercise, forKey: "CurrentlyOnExercise")
        }
        if exerciseNote != nil{
            aCoder.encode(exerciseNote, forKey: "ExerciseNote")
        }
        if exerciseNumber != nil{
            aCoder.encode(exerciseNumber, forKey: "ExerciseNumber")
        }
        if iD != nil{
            aCoder.encode(iD, forKey: "ID")
        }
        if repetitions != nil{
            aCoder.encode(repetitions, forKey: "Repetitions")
        }
        if tenseRelax != nil{
            aCoder.encode(tenseRelax, forKey: "TenseRelax")
        }
    }
}