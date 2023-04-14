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
    
    func readTotalTransactionByCategory(category: Categories, monthNum: Int) -> Double {
        let realm = try! Realm()
        
        let dataTransaction = realm.objects(TransactionEntity.self)
            .sorted(byKeyPath: "tr_date", ascending: false)
        
        let keyPath: KeyPath<TransactionEntity, Double> = \TransactionEntity.tr_amount
        
        if (category.rawValue == Categories.all.rawValue){
            return 0
        }
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        
        var startDate: Date? = nil
        var endDate: Date? = nil
        
        if monthNum == 0  {
            startDate = Date().startOfMonth()
            endDate = Date().endOfMonth()
        } else {
            if monthNum > month {
                startDate = createDate(day: 1, month: monthNum, year: (year - 1))
                
                endDate = Calendar.current.date(byAdding: .day, value: -1,
                                                to:  createDate(day: 1, month: monthNum + 1, year: (year - 1))!)
            } else {
                startDate = createDate(day: 1, month: monthNum, year: (year))
                
                endDate = Calendar.current.date(byAdding: .day, value: -1,
                                                to:  createDate(day: 1, month: monthNum + 1, year: (year))!)
            }
        }
        
        if let startDate = startDate, let endDate = endDate {
            let dataFiltered: Double = dataTransaction.where {
                ($0.tr_category == category.rawValue) &&
                ($0.tr_date.contains(startDate...endDate))
            }.sum(of: keyPath)
            
            return dataFiltered
        } else {
            return 0
        }
    }
    
    func readTransactions() -> [TransactionEntity]{
        let realm = try! Realm()
        
        let dataTransaction = realm.objects(TransactionEntity.self)
            .sorted(byKeyPath: "tr_date", ascending: false)
        
        
        return dataTransaction.map { $0 }
    }
    
    private func createDate(day: Int, month: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: "IDN")
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        let newCalendar = Calendar(identifier: .gregorian)
        return newCalendar.date(from: dateComponents)
    }
    
    func readTransactionByFilter(monthNum: Int, category: String) -> [TransactionEntity]{
        
        let realm = try! Realm()
        
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        
        
        var startDate: Date? = nil
        var endDate: Date? = nil
        
        if monthNum == 0  {
            startDate = nil
            endDate = nil
        } else {
            if monthNum > month {
                startDate = createDate(day: 1, month: monthNum, year: (year - 1))
                
                endDate = Calendar.current.date(byAdding: .day, value: -1,
                                                to:  createDate(day: 1, month: monthNum + 1, year: (year - 1))!)
            } else {
                startDate = createDate(day: 1, month: monthNum, year: (year))
                
                endDate = Calendar.current.date(byAdding: .day, value: -1,
                                                to:  createDate(day: 1, month: monthNum + 1, year: (year))!)
            }
        }
        
        let dataTransaction = realm.objects(TransactionEntity.self)
            .sorted(byKeyPath: "tr_date", ascending: false)
        
        if let startDate = startDate, let endDate = endDate {
            if category == Categories.all.rawValue {
                let dataFiltered = dataTransaction.where {
                    ($0.tr_date.contains(startDate...endDate))
                }
                return dataFiltered.map { $0 }
            } else {
                let dataFiltered = dataTransaction.where {
                    ($0.tr_category == category) &&
                    ($0.tr_date.contains(startDate...endDate))
                }
                
                return dataFiltered.map { $0 }
            }
        } else {
            if category == Categories.all.rawValue {
                return dataTransaction.map { $0 }
            } else {
                let dataFiltered = dataTransaction.where {
                    ($0.tr_category == category)
                }
                return dataFiltered.map { $0 }
            }
        }
    }
    
    func readTotal(cashflow: CashFlow, monthNum: Int) -> Double {
        let realm = try! Realm()
        
        let dataTransaction = realm.objects(TransactionEntity.self)
            .sorted(byKeyPath: "tr_date", ascending: false)
        
        let keyPath: KeyPath<TransactionEntity, Double> = \TransactionEntity.tr_amount
        
        var cashflowType: String? = nil
        
        switch(cashflow){
            case .income:
                cashflowType = CashFlow.income.rawValue
            case .expense:
                cashflowType = CashFlow.expense.rawValue
        }
        
        
        var startDate: Date? = nil
        var endDate: Date? = nil
        
        let currentDate = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        
        if monthNum == 0  {
            startDate = Date().startOfMonth()
            endDate = Date().endOfMonth()
        } else {
            if monthNum > month {
                startDate = createDate(day: 1, month: monthNum, year: (year - 1))
                
                endDate = Calendar.current.date(byAdding: .day, value: -1,
                                                to:  createDate(day: 1, month: monthNum + 1, year: (year - 1))!)
            } else {
                startDate = createDate(day: 1, month: monthNum, year: (year))
                
                endDate = Calendar.current.date(byAdding: .day, value: -1,
                                                to:  createDate(day: 1, month: monthNum + 1, year: (year))!)
            }
        }
        
        
        if let cashflowType = cashflowType, let startDate = startDate, let endDate = endDate {
            let dataFiltered: Double = dataTransaction.where {
                ($0.tr_cashflow == cashflowType) &&
                ($0.tr_date.contains(startDate...endDate))
            }.sum(of: keyPath)
            
            return dataFiltered
        } else {
            return 0
        }
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
            startDate = Date().startOfDay()
            endDate = Date().endOfDay()
        case .month:
            startDate = Date().startOfMonth()
            endDate = Date().endOfMonth()
        case .year:
            startDate = Date().startOfYear()
            endDate = Date().endOfYear()
        case .all:
            startDate = nil
            endDate = nil
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
