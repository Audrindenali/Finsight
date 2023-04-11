//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import Foundation
import RealmSwift

class TransactionEntity: Object {
    @Persisted(primaryKey: true) var _id: String
    @Persisted var tr_cashflow: String = ""
    @Persisted var tr_category: String = ""
    @Persisted var tr_amount: Double = 0
    @Persisted var tr_date: Date = Date()
    @Persisted var tr_description : String = ""
}
