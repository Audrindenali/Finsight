//
//  ItemTransaction.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct ItemTransactionHome: View {
    var cashFlowType: String
    var category: String
    var amount: String
    
    var body: some View {
        HStack {
            Image(systemName: cashFlowType == CashFlow.income.rawValue ? "arrow.up" : "arrow.down")
                .font(.system(.title3).bold())
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .padding(10)
                .foregroundColor(.white)
                .background(Color.mainColor)
                .clipShape(Circle())
            
            Text(amount)
                .font(.system(.title2))
                .padding(.all, 10)
                .lineLimit(0)
            
            Spacer()
            
            Text(category)
                .font(.body)
        }
        .padding(.all, 8)
        .background(Color.mainGray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
    }
}

struct ItemTransaction_Previews: PreviewProvider {
    static var previews: some View {
        ItemTransactionHome(cashFlowType: "Income", category: "Investment", amount: "Rp10.000.000")
    }
}
