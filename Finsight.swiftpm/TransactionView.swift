//
//  TransactionView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    @State var monthFilterSelected = 0
    @State var categoryFilterSelected = 0
    
    var months = [
        "All",
        "Januari",
        "Februari",
        "Maret",
        "April",
        "Mei",
        "Juni",
        "Juli",
        "Agustus",
        "September",
        "Oktober",
        "November",
        "Desember"
    ]
    
    let categories = Categories.allCases.map { $0.rawValue }
    
    var body: some View {
        ZStack {
            Color.mainColor
                .ignoresSafeArea()
            VStack {
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
                        CustomMenu(menus: months, selectedMenu: $monthFilterSelected, placeholderMenu: "Month")
                        .padding(.leading, 16)
                        .padding(.vertical, 16)
                        
                        CustomMenu(menus: categories, selectedMenu: $categoryFilterSelected, placeholderMenu: "Category")
                        .padding(.leading, 16)
                        .padding(.vertical, 16)
                    }
                }
                
                if transactionViewModel.transactions.isEmpty {
                    Spacer()
                    
                    Text("There isn't data found")
                        .foregroundColor(.white)
                        .font(.system(.title3).bold())
                        .multilineTextAlignment(.center)
                        
                    
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(transactionViewModel.transactions, id: \._id){ transaction in
                            ItemMainTransaction(category: transaction.tr_category, description: transaction.tr_description, amount: "\(transaction.tr_amount.formatted(FloatingPointFormatStyle()))", date: getTimeTransaction(date: transaction.tr_date), cashFlow: transaction.tr_cashflow)
                                .padding(.horizontal, 16)
                                .padding(.top, 8)
                            
                        }
                    }
                }
                
                
            }
        }
        .onAppear{
            transactionViewModel.fetchTransactionByFilter(monthNum: monthFilterSelected, category: categories[categoryFilterSelected])
            print(transactionViewModel.transactions)
        }
        .onChange(of: monthFilterSelected) { monthNum in
            transactionViewModel.fetchTransactionByFilter(monthNum: monthNum, category: categories[categoryFilterSelected])
        }
        .onChange(of: categoryFilterSelected) { categoryNum in
            transactionViewModel.fetchTransactionByFilter(monthNum: monthFilterSelected, category: categories[categoryNum])
        }
    }
    
    private func getTimeTransaction(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        
        return formatter.string(from: date)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
