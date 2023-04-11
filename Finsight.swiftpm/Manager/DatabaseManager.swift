//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 11/04/23.
//

import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    
    func saveTransaction(
        tr_category: String,
        tr_amount: Double,
        tr_date: Date,
        tr_description: String,
        tr_cashflow: String
    ){
        let realm = try! Realm()
        
        let transaction = TransactionEntity()
        transaction._id = UUID().uuidString
        transaction.tr_category = tr_category
        transaction.tr_amount = tr_amount
        transaction.tr_date = tr_date
        transaction.tr_description = tr_description
        transaction.tr_cashflow = tr_cashflow
        
        do {
            try realm.write {
                realm.add(transaction)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func readTransactions() -> [TransactionEntity]{
        let realm = try! Realm()
        
        let dataTransaction = realm.objects(TransactionEntity.self)
            .sorted(byKeyPath: "tr_date", ascending: false)
        
        
        return dataTransaction.map { $0 }
    }
    
    func readTransactionByPeriod(periodFilter: PeriodFilter) -> [TransactionEntity]{
        let realm = try! Realm()
        
        var startDate: Date?
        var endDate: Date?
        
        switch(periodFilter){
            case .week :
            startDate = Date().startOfWeek
            endDate = Date().endOfWeek
        case .today:
            print("today")
        case .month:
            print("month")
        case .year:
            print("year")
        case .all:
            print("all")
        }
        
        let dataTransaction = realm.objects(TransactionEntity.self)
            .sorted(byKeyPath: "tr_date", ascending: false)
        
        if let startDate = startDate, let endDate = endDate {
            let dataFiltered = dataTransaction.where {
                $0.tr_date.contains(startDate...endDate)
            }
            return dataFiltered.map { $0 }
        } else {
            return dataTransaction.map { $0 }
        }
    }
}

enum PeriodFilter {
    case week, today, month, year, all
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }

    var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 7, to: sunday)
    }
}

