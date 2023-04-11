//
//  File.swift
//  
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import Foundation

class TransactionViewModel: ObservableObject {
    @Published var transactions: [TransactionEntity] = []
    
    func fetchTransactions(){
        transactions = DatabaseManager.shared.readTransactions()
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
