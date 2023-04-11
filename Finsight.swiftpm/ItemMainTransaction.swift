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
    
    
    var body: some View {
        VStack {
            HStack {
                Text(category)
                    .font(.system(.title3))
                
                Spacer()
                
                Text(amount)
                    .font(.system(.title3))
                    .bold()
            }
            
            HStack {
                Text(description)
                    .font(.system(.body))
                    .lineLimit(0)
                
                Spacer()
                
                Text(date)
                    .font(.system(.body))
            }.padding(.top, 8)
        }
        .padding(.all, 16)
        .background(.white)
        .cornerRadius(24)
    }
}

struct ItemMainTransaction_Previews: PreviewProvider {
    static var previews: some View {
        ItemMainTransaction(category: "Shopping", description: "Lorem ipsum dolor sit amet", amount: "Rp1.000.000", date: "10:00 AM")
    }
}
