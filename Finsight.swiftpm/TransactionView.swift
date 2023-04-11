//
//  TransactionView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    @State var monthFilterSelected = "All"
    @State var categoryFilterSelected = "All"
    
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
    
    let categories = [
        "All",
        "Shopping",
        "Investment",
        "School"
    ]
    
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
                
                ScrollView {
                    ForEach(1...20, id: \.self){ _ in
                        ItemMainTransaction(category: "Shopping", description: "Lorem ipsum dolor sit amet", amount: "Rp100.000.000", date: "10:00 AM")
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                        
                    }
                }
            }
        }
        .onAppear{
//            transactionViewModel.fetchTransactions()
//            print(transactionViewModel.transactions)
        }
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView()
    }
}
