//
//  AddTransactionView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI


struct AddTransactionView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    
    @State private var nominal: String = ""
    @State private var categorySelection: String = "Investment"
    let categories = ["Investment", "School", "Shopping", "Food"]
    
    @State private var description: String = ""
    @State private var isIncome = true
    @State private var date: String = ""
    
    var body: some View {
        GeometryReader { screen in
            VStack {
                Text("How Much?")
                TextField("Enter the nominal", text: $nominal)
                Picker("Select Category", selection: $categorySelection) {
                    ForEach(categories, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(.menu)
                
                TextField("Description", text: $description)
                
                HStack {
                    Button {
                        isIncome = true
                    } label: {
                        Text("Income")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(isIncome ? .red : .gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    Button {
                        isIncome = false
                    } label: {
                        Text("Expense")
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(!isIncome ? .red : .gray)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                TextField("Data", text: $date)
                
                Button {
                    transactionViewModel.saveTransaction(tr_category: self.categorySelection, tr_amount: Double(nominal) ?? 0, tr_date: Date(), tr_description: description)
                } label: {
                    Text("Continue")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .onAppear {
                transactionViewModel.fetchTransactions()
                print(transactionViewModel.transactions)
            }
        }
    }
}

struct AddTransactionView_Previews: PreviewProvider {
    static var previews: some View {
        AddTransactionView()
    }
}
