//
//  ItemMainTransaction.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 11/04/23.
//

import SwiftUI


struct ItemMainTransaction: View {
    var category: String
    var description: String
    var amount: String
    var date: String
    var cashFlow: String
    
    
    var body: some View {
        VStack {
            HStack {
                Text(category)
                    .font(.system(.title3))
                    .foregroundColor(.black)
                
                Spacer()
                
                Text((cashFlow == CashFlow.income.rawValue ? "+ " : "- ") + amount)
                    .font(.system(.title3))
                    .bold()
                    .foregroundColor(cashFlow == CashFlow.income.rawValue ? .green : .red)
            }
            
            HStack {
                Text(description)
                    .font(.system(.body))
                    .lineLimit(0)
                    .foregroundColor(.black)
                
                Spacer()
                
                Text(date)
                    .font(.system(.body))
                    .foregroundColor(.black)
            }.padding(.top, 8)
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(24)
    }
}

struct ItemMainTransaction_Previews: PreviewProvider {
    static var previews: some View {
        ItemMainTransaction(category: "Shopping", description: "Lorem ipsum dolor sit amet", amount: "Rp1.000.000", date: "10:00 AM", cashFlow: "Income")
    }
}
