//
//  SqlLiteManger.swift
//  KegelMaster
//
//  Created by iMac on 10/07/20.
//  Copyright © 2020 iMac. All rights reserved.
//

import UIKit

let DB_Name: String = "KegelMaster"

class SqlLiteManger: NSObject {

    
    func getData(query:String) -> [Any] {
        
        var final:[[String : Any]] = [[String : Any]]()
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path1 = path[0]
        let fullpath = path1.appending("/\(DB_Name).db")
        var qp:OpaquePointer? = nil
        if sqlite3_open(fullpath,&qp) == SQLITE_OK
        {
            var stmt : OpaquePointer? = nil
            
            if sqlite3_prepare_v2(qp, query, -1, &stmt, nil) == SQLITE_OK
            {
                while sqlite3_step(stmt) ==  SQLITE_ROW {
                    var dict = [String: Any]()
                    
                    for columnNumber in 0..<sqlite3_column_count(stmt){
                        var stValue: String = ""
                        if sqlite3_column_text(stmt, columnNumber) != nil{
                             stValue =  String(cString: sqlite3_column_text(stmt, columnNumber));
                        }
                        dict[String(cString: sqlite3_column_name(stmt, columnNumber))] = stValue
                    }
                    final.append(dict)
                }
            }
            sqlite3_finalize(stmt)
            sqlite3_close(qp)
        }
        return final
    }
    
    func UpdateData(query:String) -> Bool{
        var status:Bool = false
   
//        let finalpath = Bundle.main.path(forResource: DB_Name, ofType: "db")
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let path1 = path[0]
        let fullpath = path1.appending("/\(DB_Name).db")
        var qp : OpaquePointer? = nil
    
        if sqlite3_open(fullpath,&qp) ==  SQLITE_OK
        {
            var stmt:OpaquePointer? = nil
            if sqlite3_prepare_v2(qp, query, -1, &stmt, nil) == SQLITE_OK
            {
                sqlite3_step(stmt)
                status = true
            }
            sqlite3_finalize(stmt)
            sqlite3_close(qp)
        }
       return status
    }
}
