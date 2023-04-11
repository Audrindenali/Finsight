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
                                    
                                    Text("Month")
                                        .font(.system(.title3))
                                }
                                .padding(.all, 12)
                                .overlay {
                                    Capsule()
                                        .stroke(.black)
                                }
                            }
                            .padding(.all, 8)
                            
                            
                            
                        }
                    }
                }
                
                ScrollView {
                    ForEach(1...20, id: \.self){ _ in
                        
                        
                        VStack {
                            HStack {
                                Text("Shopping")
                                    .font(.system(.title3))
                                
                                Spacer()
                                
                                Text("500.000")
                                    .font(.system(.title3))
                                    .bold()
                            }
                            
                            HStack {
                                Text("Buy Some Grocery")
                                    .font(.system(.body))
                                
                                Spacer()
                                
                                Text("10.00 AM")
                                    .font(.system(.body))
                            }.padding(.top, 8)
                        }
                        .padding(.all, 16)
                        .background(.white)
                        .cornerRadius(16)
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
