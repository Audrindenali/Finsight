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
        let day = calendar.component(.day, from: currentDate)
        
        
        var startDate: Date? = nil
        var endDate: Date? = nil
        
        if monthNum == 0 {
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
            let dataFiltered = dataTransaction.where {
                $0.tr_date.contains(startDate...endDate)
            }
            return dataFiltered.map { $0 }
        } else {
            return dataTransaction.map { $0 }
        }
    }
    
    func readTotal(cashflow: CashFlow) -> Double {
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
        
        if let cashflowType = cashflowType, let startDate = Date().startOfMonth(), let endDate = Date().endOfMonth() {
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

enum CashFlow: String {
    case income = "Income"
    case expense = "Expense"
}

enum PeriodFilter: String, CaseIterable {
    case all = "All"
    case week = "Week"
    case today = "Today"
    case month = "Month"
    case year = "Year"
}

extension Date {
    func startOfDay() -> Date? {
            return Calendar.current.startOfDay(for: self)
        }

        func endOfDay() -> Date? {
            let startDay = Calendar.current.startOfDay(for: self)
            var components = DateComponents()
            components.day = 1
            components.second = -1
            return Calendar.current.date(byAdding: components, to: startDay)
        }
    
    
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
    
    func startOfMonth() -> Date? {
            return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))
        }
        
        func endOfMonth() -> Date? {
            return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth()!)
        }
    
    func endOfYear() -> Date? {
        let year = Calendar.current.component(.year, from: Date())
        // Get the first day of next year
        guard let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1)) else { return nil }
        
        return Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear)
    }
    
    func startOfYear() -> Date? {
        let year = Calendar.current.component(.year, from: Date())
        // Get the first day of next year
        guard let endOfPrevYear = Calendar.current.date(from: DateComponents(year: year - 1 , month: 12, day: 31)) else { return nil }
        
        return Calendar.current.date(byAdding: .day, value: +1, to: endOfPrevYear)
    }
    
}

