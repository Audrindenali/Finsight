//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import Foundation
import RealmSwift

//@Persisted(primaryKey: true) var _id: String
//@Persisted var tr_category: String = ""
//@Persisted var tr_amount: Double = 0
//@Persisted var tr_date: Date = Date()
//@Persisted var tr_description : String = ""

class DatabaseManager {
    static let shared = DatabaseManager()
    
    func saveTransaction(
        tr_category: String,
        tr_amount: Double,
        tr_date: Date,
        tr_description: String
    ){
        let realm = try! Realm()
        
        let transaction = TransactionEntity()
        transaction._id = UUID().uuidString
        transaction.tr_category = tr_category
        transaction.tr_amount = tr_amount
        transaction.tr_date = tr_date
        transaction.tr_description = tr_description
        
        do {
            try realm.write {
                realm.add(transaction)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
