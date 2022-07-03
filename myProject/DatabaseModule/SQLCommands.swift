//
//  SQLCommands.swift
//  myProject
//
//  Created by Владимир Курганов on 01.07.2022.
//

import Foundation
import SQLite
import SQLite3

final class SQLCommands {
    
    static var table = Table("databaseModel")
    static let id = Expression<String>("id")
    static let description = Expression<String>("description")
    static let image = Expression<Data>("image")
    
    static func createDataTable() {
        
        guard let database = SQLDatabase.shared.database else { return }
        
        do {
            
            try database.run(table.create(ifNotExists: true) { table in
                table.column(id)
                table.column(description)
                table.column(image)
                
            })
            
        } catch {
            
            print("Table already exists: \(error.localizedDescription)")
            
        }
    }
    
    static func insertRow(_ dataValue: DatabaseModel) -> Bool? {
        
        guard let database = SQLDatabase.shared.database else { return nil }
        
        do {
            
            try database.run(table.insert(id <- dataValue.id, description <- dataValue.description,
                 image <- dataValue.image))
            return true
            
        } catch let Result.error(message, code, statement) where code == SQLITE_CONSTRAINT {
            
            print("Insert row failed: \(message), in \(String(describing: statement))")
            return false
            
            
        } catch let error {
            
            print("Insertion failed: \(error.localizedDescription)")
            return false
            
        }
    }
    
    static func presentRows() -> [DatabaseModel]? {
        
        guard let database = SQLDatabase.shared.database else { return nil }
        
        var dataArray = [DatabaseModel]()
        
        table = table.order(id.desc)
        
        do {
            
            for data in try database.prepare(table) {
                
                let idValue = data[id]
                let descriptionValue = data[description]
                let imageValue = data[image]
                let dataObject = DatabaseModel(id: idValue, description: descriptionValue, image: imageValue)
                dataArray.append(dataObject)

            }
            
        } catch {
            
            print("Present row error: \(error.localizedDescription)")
            
        }
        
        return dataArray
        
    }
    
    static func deleteRow(dataId: String) {
        
        guard let database = SQLDatabase.shared.database else { return }
        
        do {
            
            let data = table.filter(id == dataId).limit(1)
            try database.run(data.delete())
            
        } catch {
            
            print("Delete row error: \(error.localizedDescription)")
            
        }
    }
}
