//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import Foundation

class TransactionViewModel: ObservableObject {
    @Published var transactions: [TransactionEntity] = []
    @Published var totalExpense: Double = 0
    @Published var totalIncome: Double = 0
    @Published var totalBalance: Double = 0
    
    func fetchTransactions(){
        transactions = DatabaseManager.shared.readTransactions()
    }
    
    func fetchTransactionByFilter(monthNum: Int, category: String){
        transactions = DatabaseManager.shared.readTransactionByFilter(monthNum: monthNum, category: category)
    }
    
    func fetchTransactionByPeriod(periodFilter: PeriodFilter){
        transactions = DatabaseManager.shared.readTransactionByPeriod(periodFilter: periodFilter)
    }
    
    func fetchTotalStats(){
        totalIncome = DatabaseManager.shared.readTotal(cashflow: .income)
        totalExpense = DatabaseManager.shared.readTotal(cashflow: .expense)
            totalBalance = totalIncome - totalExpense
        
    }
    
    func saveTransaction(
        tr_category: String,
        tr_amount: Double,
        tr_date: Date,
        tr_description: String,
        tr_cashflow: String
    ){
        DatabaseManager.shared.saveTransaction(tr_category: tr_category, tr_amount: tr_amount, tr_date: tr_date, tr_description: tr_description, tr_cashflow: tr_cashflow)
    }
}
