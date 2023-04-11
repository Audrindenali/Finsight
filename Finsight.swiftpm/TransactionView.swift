//
//  TransactionView.swift
//  Finsight
//
//  Created by Rivaldo Fernandes on 10/04/23.
//

import SwiftUI

struct TransactionView: View {
    @EnvironmentObject var transactionViewModel: TransactionViewModel
    
    var body: some View {
        ZStack {
            Color.mainColor
                .ignoresSafeArea()
            VStack {
                ScrollView(.horizontal,showsIndicators: false){
                    HStack {
                        ForEach(1...5, id: \.self){ _ in
                            
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "chevron.down")
                                        .font(.system(.title3))
                                        .foregroundColor(.mainText)
                                    
                                    Text("Month")
                                        .font(.system(.title3))
                                        .foregroundColor(.mainText)
                                }
                                .padding(.all, 12)
                                .overlay {
                                    Capsule()
                                        .stroke(Color.mainText)
                                }
                            }
                            .padding(.all, 8)
                            
                            
                            
                        }
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
