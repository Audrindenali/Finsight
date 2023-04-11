//
//  ItemTransaction.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct ItemTransaction: View {
    var cashFlowType: String
    var amount: String
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 18, height: 18)
                .padding(18)
                .foregroundColor(.mainColor)
                .background(.blue)
                .clipShape(Circle())
            
            Text(amount)
                .font(.system(.title2))
                .padding(.all, 10)
                .lineLimit(0)
            
            Spacer()
            
            Text(cashFlowType)
                .font(.body)
        }
        .padding(.all, 8)
        .background(.blue.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
    }
}

struct ItemTransaction_Previews: PreviewProvider {
    static var previews: some View {
        ItemTransaction(cashFlowType: "Income", amount: "Rp10.000.000")
    }
}
