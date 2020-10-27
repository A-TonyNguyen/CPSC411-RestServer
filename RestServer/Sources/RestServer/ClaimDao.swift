//  Name: Tony Nguyen
//  Date: October 25, 2020
//
//  ClaimEntityDao.swift
//  RestServer

import SQLite3
import Foundation

// Textbook uses JSONSerialization API (in Foundation module)
// JSONEncoder/JSONDecoder

struct Claim : Codable
{
    var id : UUID = UUID()
    var title : String
    var date : String
    var isSolved : Bool = false
    
    init(id : UUID?, title: String, date : String, isSolved : Bool?)
    {
        self.title = title
        self.date = date
        
        if (id != nil)
        {
            self.id = id!
        }
        if (isSolved != nil)
        {
            self.isSolved = isSolved!
        }
    }
}

class ClaimDao
{
    func addClaim(cObj : Claim)
    {
        let sqlStmt = String(format : "Insert into claimEntity (id, title, date, isSolved) values ('%@', '%@', '%@', '%@')", (cObj.id.uuidString), (cObj.title), (cObj.date), (cObj.isSolved ? 1 : 0))
        //get database connection
        let conn = Database.getInstance().getDbConnection()
        
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK
        {
            let errcode = sqlite3_errcode(conn)
            print("Failed to insert a Person record due to error \(errcode)")
        }
        // close the connection
        sqlite3_close(conn)
    }
    
    func getAll() -> [Claim]
    {
        var cList = [Claim]()
        var resultSet : OpaquePointer?
        let sqlStr = "select id, title, date, isSoved from ClaimEntity"
        let conn = Database.getInstance().getDbConnection()
        
        if sqlite3_prepare_v2(conn, sqlStr, -1, &resultSet, nil) == SQLITE_OK
        {
            while(sqlite3_step(resultSet) == SQLITE_ROW)
            {
                // Convert the record into a Person object
                // Unsafe_Pointer<CChar> Sqlite3
                let id_val = sqlite3_column_text(resultSet, 0)
                let id = UUID(uuidString: String(cString: id_val!))
                let title_val = sqlite3_column_text(resultSet, 1)
                let title = String(cString: title_val!)
                let date_val = sqlite3_column_text(resultSet, 2)
                let date = String(cString: date_val!)
                let isSolved_val = sqlite3_column_text(resultSet, 3)
                let isSolved_s = String(cString: isSolved_val!)
                let isSolved = Bool(truncating: Int(isSolved_s)! as NSNumber)
                cList.append(Claim(id:id, title:title, date:date, isSolved:isSolved))
            }
        }
        return cList
    }
}
