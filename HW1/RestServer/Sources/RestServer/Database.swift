
//   HW1
//  Ramiro Aispuro
//

import SQLite3

class Database {
    static var dbObj: Database!
    let dbName = "/Users/ramiro/Desktop/HW1/RestServer/ClaimDb.sqlite"
    var conn: OpaquePointer?
    
    init() {
        //        1. Create database
        if sqlite3_open(dbName, &conn) == SQLITE_OK {
            //          2. Create tables
            initializeDB()
            sqlite3_close(conn)
        } else {
            let errcode = sqlite3_errcode(conn)
            print("Open database failed due to error \(errcode)")
        }
    }
    
    private func initializeDB() {
        let sqlStmt = "create table if not exists claim (id text, title text, date text, isSolved int)"
        if sqlite3_exec(conn, sqlStmt, nil, nil, nil) != SQLITE_OK {
            let errcode = sqlite3_errcode(conn)
            print("Create table failed due to error \(errcode)")
        }
    }
    
    func getDBConnection() -> OpaquePointer? {
        var conn: OpaquePointer?
        if sqlite3_open(dbName, &conn) == SQLITE_OK {
            return conn
        } else {
            let errcode = sqlite3_errcode(conn)
            print("Open database failed due to error \(errcode)")
        }
        return conn
    }
    
    static func getInstance() -> Database {
        //        If database object DNE, create it
        if dbObj == nil {
            dbObj = Database()
        }
        return dbObj
    }
}
