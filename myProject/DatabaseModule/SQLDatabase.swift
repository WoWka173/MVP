//
//  SQLDatabase.swift
//  myProject
//
//  Created by Владимир Курганов on 01.07.2022.
//

import Foundation
import SQLite

final class SQLDatabase {
    
    static let shared = SQLDatabase()
    var database: Connection?

    init() {
        
        do {
            
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("Data").appendingPathExtension("sqlite3")
            database = try Connection(fileUrl.path)
            
        } catch {
            
            print(error.localizedDescription)
            
        }
    }
    
    func createTableDatabase() {
        
        SQLCommands.createDataTable()
        
    }
}
